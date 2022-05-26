module rgb_hsv (
  input [7:0] r,
  input [7:0] g,
  input [7:0] b,
  output reg [23:0] hsv
);

reg [1:0] color_max;
reg [7:0] max, min;
wire [8:0] hueR, hueG, hueB, satQ;
reg [15:0] sat;
wire [7:0] diff = max - min;

rgb_hue hr (g, b, diff, 9'd360, hueR);
rgb_hue hg (b, r, diff, 9'd120, hueG);
rgb_hue hb (r, g, diff, 9'd240, hueB);
divide div_sat (diff, max, satQ);

always @(*) begin
  
  max = 8'h00;
  min = 8'h00;
  color_max = 2'b00;
  
  // Max min check
  if (r >= g && r >= b) begin
    max = r;
	 color_max = 2'b01;
  end
  else if (g >= r && g >= b) begin
    max = g;
	 color_max = 2'b10;
  end
  else if (b >= g && b >= r) begin
    max = b;
	 color_max = 2'b11;
  end

  if (r <= g && r <= b) begin
    min = r;
  end
  else if (g <= r && g <= b) begin
    min = g;
  end
  else if (b <= g && b <= r) begin
    min = b;
  end
  
  //diff check
  if (diff == 8'h00) begin
    color_max = 2'b00;
  end
  
  //hue set
  case (color_max)
    2'b01: //red
	   begin
		  hsv[23:15] = hueR;
		end
    2'b10: //green
	   begin
		  hsv[23:15] = hueG;
		end
    2'b11: //blue
	   begin
		  hsv[23:15] = hueB;
		end
    default:
	   begin
		  hsv[23:15] = 9'h000;
		end
  endcase
  
  
  //saturation
  sat = 7'b1111_111 * satQ;
  hsv[14:8] = sat[14:8];
  if (max == 8'h00) begin
    hsv[14:8] = 7'b0000_000;
  end
  
  
  //value
  hsv[7:0] = max;
  

end

endmodule

module rgb_hue (
  input [7:0] in1,
  input [7:0] in2,
  input [7:0] delta,
  input [8:0] offset,
  output [8:0] hue
);

reg neg;
reg [7:0] diff;
wire [8:0] div_ans;
reg [16:0] h;

divide d0 (diff, delta, div_ans);
mod360 m360 ({2'b00, h[16:8]}, hue);

always @(*) begin
  if (in1 >= in2) begin
    diff = in1 - in2;
	 neg = 1'b0;
  end
  else begin
    diff = in2 - in1;
	 neg = 1'b1;
  end
  
  if (neg == 1'b1) begin
    h = (offset<<8) - 6'd60 * div_ans;
  end
  else begin
    h = 6'd60 * div_ans + (offset<<8);
  end
  
end

endmodule




