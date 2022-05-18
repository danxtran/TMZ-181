`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module colordetc (
  input clk,
  input rst,
  input [7:0] r,
  input [7:0] g,
  input [7:0] b,
  input [3:0] clr_sel,
  output [7:0] outR,
  output [7:0] outG,
  output [7:0] outB,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

assign pass_thru = pass_in;

  wire signed [24:0] greeness;
  wire signed [24:0] redness;
  wire signed [24:0] bluewness;
  wire signed [24:0] thresh_g,thresh_r,thresh_b;
  wire [7:0] gs;
  reg [7:0] out_reg_r, out_reg_g, out_reg_b, shift_r, shift_g, shift_b;
	reg [1:0] ctrl_c, ctrl;
	
  assign redness = r*(r-g)*(r-b);
  assign greeness = g*(g-r)*(g-b);
  assign blueness = b*(b-r)*(b-g);
  assign thresh_g = 25'b0_0000_0001_0100_0011_1101_1010;
  assign thresh_r = 25'b0_0001_1110_0100_0011_1101_1010;
  assign thresh_b =0;
 
  assign outR = out_reg_r;
  assign outG = out_reg_g;
  assign outB = out_reg_b;
  grayscale_unclk grey (r,g,b,gs,,);
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
		out_reg_r = r;
	  out_reg_g = g;
	  out_reg_b = b;
    case (ctrl)
      2'b00: begin //highlight g
			if(greeness > thresh_g) begin
				out_reg_r = r;
				out_reg_g = g;
				out_reg_b = b;

			end else begin
				out_reg_r = gs;
				out_reg_g = gs;
				out_reg_b = gs;
			end
      end
      2'b01: begin //highlight r
			if(redness > thresh_r) begin
				out_reg_r = r;
				out_reg_g = g;
				out_reg_b = b;

			end else begin
				out_reg_r = gs;
				out_reg_g = gs;
				out_reg_b = gs;
			end
      end
      2'b10: begin //highlight b
			if(blueness > thresh_b) begin
				out_reg_r = r;
				out_reg_g = g;
				out_reg_b = b;

			end else begin
				out_reg_r = gs;
				out_reg_g = gs;
				out_reg_b = gs;
			end
      end
		default :begin
			out_reg_r = r;
        out_reg_g = g;
        out_reg_b = b;
		  end
    endcase
  end
  always @(posedge clk) begin
	ctrl <= #1 ctrl_c;
  end
  
endmodule
