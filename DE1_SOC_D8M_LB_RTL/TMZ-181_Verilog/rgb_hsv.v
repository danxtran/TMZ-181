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
reg [21:0] h;

divide d0 (diff, delta, div_ans);
mod360 m360 (neg, h[21:8], hue);

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
    h = 6'd60 * div_ans - (offset<<8);
  end
  else begin
    h = 6'd60 * div_ans + (offset<<8);
  end
  
end

endmodule

module divide (
  input [7:0] num,
  input [7:0] dem,
  output [8:0] ans
);

wire [15:0] next7, next6, next5, next4, next3, next2, next1, next0;

div_step d8 ({8'h00, num}, dem, ans[8], next7);
div_step d7 (next7, dem, ans[7], next6);
div_step d6 (next6, dem, ans[6], next5);
div_step d5 (next5, dem, ans[5], next4);
div_step d4 (next4, dem, ans[4], next3);
div_step d3 (next3, dem, ans[3], next2);
div_step d2 (next2, dem, ans[2], next1);
div_step d1 (next1, dem, ans[1], next0);
div_step d0 (next0, dem, ans[0], );

endmodule

module div_step (
  input [15:0] top,
  input [7:0] bot,
  output reg Q,
  output reg [15:0] next
);

wire [15:0] diff = top - bot;

always @(*) begin
  Q = 1'b0;
  next = top << 1;
  if (top >= bot) begin
    Q = 1'b1;
    next = {diff[13:0], 1'b0};
  end
end

endmodule

module mod360 (
  input neg,
  input [13:0] in,
  output reg [8:0] out
);


reg [13:0] diff;

always @(*) begin

  if (in >= 14'd15480) begin
    diff = in - 14'd15480;
  end
  else if (in >= 14'd15120) begin
    diff = in - 14'd15120;
  end
  else if (in >= 14'd14760) begin
    diff = in - 14'd14760;
  end
  else if (in >= 14'd14400) begin
    diff = in - 14'd14400;
  end
  else if (in >= 14'd14040) begin
    diff = in - 14'd14040;
  end
  else if (in >= 14'd13680) begin
    diff = in - 14'd13680;
  end
  else if (in >= 14'd13320) begin
    diff = in - 14'd13320;
  end
  else if (in >= 14'd12960) begin
    diff = in - 14'd12960;
  end
  else if (in >= 14'd12600) begin
    diff = in - 14'd12600;
  end
  else if (in >= 14'd12240) begin
    diff = in - 14'd12240;
  end
  else if (in >= 14'd11880) begin
    diff = in - 14'd11880;
  end
  else if (in >= 14'd11520) begin
    diff = in - 14'd11520;
  end
  else if (in >= 14'd11160) begin
    diff = in - 14'd11160;
  end
  else if (in >= 14'd10800) begin
    diff = in - 14'd10800;
  end
  else if (in >= 14'd10440) begin
    diff = in - 14'd10440;
  end
  else if (in >= 14'd10080) begin
    diff = in - 14'd10080;
  end
  else if (in >= 14'd9720) begin
    diff = in - 14'd9720;
  end
  else if (in >= 14'd9360) begin
    diff = in - 14'd9360;
  end
  else if (in >= 14'd9000) begin
    diff = in - 14'd9000;
  end
  else if (in >= 14'd8640) begin
    diff = in - 14'd8640;
  end
  else if (in >= 14'd8280) begin
    diff = in - 14'd8280;
  end
  else if (in >= 14'd7920) begin
    diff = in - 14'd7920;
  end
  else if (in >= 14'd7560) begin
    diff = in - 14'd7560;
  end
  else if (in >= 14'd7200) begin
    diff = in - 14'd7200;
  end
  else if (in >= 14'd6840) begin
    diff = in - 14'd6840;
  end
  else if (in >= 14'd6480) begin
    diff = in - 14'd6480;
  end
  else if (in >= 14'd6120) begin
    diff = in - 14'd6120;
  end
  else if (in >= 14'd5760) begin
    diff = in - 14'd5760;
  end
  else if (in >= 14'd5400) begin
    diff = in - 14'd5400;
  end
  else if (in >= 14'd5040) begin
    diff = in - 14'd5040;
  end
  else if (in >= 14'd4680) begin
    diff = in - 14'd4680;
  end
  else if (in >= 14'd4320) begin
    diff = in - 14'd4320;
  end
  else if (in >= 14'd3960) begin
    diff = in - 14'd3960;
  end
  else if (in >= 14'd3600) begin
    diff = in - 14'd3600;
  end
  else if (in >= 14'd3240) begin
    diff = in - 14'd3240;
  end
  else if (in >= 14'd2880) begin
    diff = in - 14'd2880;
  end
  else if (in >= 14'd2520) begin
    diff = in - 14'd2520;
  end
  else if (in >= 14'd2160) begin
    diff = in - 14'd2160;
  end
  else if (in >= 14'd1800) begin
    diff = in - 14'd1800;
  end
  else if (in >= 14'd1440) begin
    diff = in - 14'd1440;
  end
  else if (in >= 14'd1080) begin
    diff = in - 14'd1080;
  end
  else if (in >= 14'd720) begin
    diff = in - 14'd720;
  end
  else if (in >= 14'd360) begin
    diff = in - 14'd360;
  end
  else if (in >= 14'd0) begin
    diff = in - 14'd0;
  end
  else begin
    diff = 14'd00000;
  end
  
  if (neg == 1'b0) begin
    out = diff [8:0];
  end
  else begin
    out = 9'd360 - diff [8:0];
  end

end

endmodule
