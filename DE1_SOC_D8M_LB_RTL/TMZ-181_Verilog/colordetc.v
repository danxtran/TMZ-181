`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module colordetc (
  input clk,
  input rst,
  input [3:0] clr_sel,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in,
  output reg [23:0] pass_thru
);

reg [23:0] pixel_out_c;

reg [1:0] ctrl_c, ctrl;

wire [9:0] sat = {pixel_in[14:8], 3'b000}; //increase saturation value 4x
wire [7:0] S;

saturate s0 (sat, S);

always @(*) begin
  // level handling
  if (clr_sel[3] == 1'b1) begin
    ctrl_c = 2'b01;
  end
  else if (clr_sel[2] == 1'b1) begin
    ctrl_c = 2'b00;
  end
  else if (clr_sel[1] == 1'b1) begin
    ctrl_c = 2'b10;
  end
  else if (clr_sel[0] == 1'b1) begin
    ctrl_c = 2'b11;
  end
  else begin
    ctrl_c = ctrl;
  end
  if (rst == 1'b1) begin // reset logic
    ctrl_c = 2'b11;
  end
		  
end

  always @(*) begin
	 pixel_out_c = pixel_in;
    case (ctrl)
      2'b00: begin //highlight g
			if(pixel_in[23:15] >= 9'd80 && pixel_in[23:15] <= 9'd160) begin
				pixel_out_c[14:8] = S[7:1];
			end
			else begin
				pixel_out_c[14:8] = 7'b0000_000;
			end
      end
      2'b01: begin //highlight r
			if(pixel_in[23:15] >= 9'd330 || pixel_in[23:15] <= 9'd30) begin
				pixel_out_c[14:8] = S[7:1];
			end 
			else begin
				pixel_out_c[14:8] = 7'b0000_000;
			end
      end
      2'b10: begin //highlight b
			if(pixel_in[23:15] >= 9'd160 && pixel_in[23:15] <= 9'd280) begin
				pixel_out_c[14:8] = S[7:1];
			end 
			else begin
				pixel_out_c[14:8] = 7'b0000_000;
			end
      end
		default: begin
			pixel_out_c = pixel_in;
		  end
    endcase
  end
  
  always @(posedge clk) begin
	ctrl <= #1 ctrl_c;
	pixel_out <= #1 pixel_out_c;
   pass_thru <= #1 pass_in;	
  end
  
endmodule
