module colordetc (
  input [3:0] clr_sel,
  input [7:0] in_r,
  input [7:0] in_g,
  input [7:0] in_b,
  input rst,
  input clk,
  output [7:0] out_r,
  output [7:0] out_g,
  output [7:0] out_b,
  output [1:0] ctrl_out
);

  wire signed [24:0] greeness;
  wire signed [24:0] redness;
  wire signed [24:0] bluewness;
  wire signed [24:0] thresh_g,thresh_r,thresh_b;
  wire [7:0] gs;
  reg [7:0] out_reg_r, out_reg_g, out_reg_b, shift_r, shift_g, shift_b;
	reg [1:0] ctrl_c, ctrl;
	
  assign redness = in_r*(in_r-in_g)*(in_r-in_b);
  assign greeness = in_g*(in_g-in_r)*(in_g-in_b);
  assign blueness = in_b*(in_b-in_r)*(in_b-in_g);
  assign thresh_g = 25'b0_0000_0001_0100_0011_1101_1010;
  assign thresh_r = 25'b0_0001_1110_0100_0011_1101_1010;
  assign thresh_b =0;
 
  assign out_r = out_reg_r;
  assign out_g = out_reg_g;
  assign out_b = out_reg_b;
  assign ctrl_out = ctrl;
  grayscale_unclk grey (in_r,in_g,in_b,gs,,);
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
		out_reg_r = in_r;
	  out_reg_g = in_g;
	  out_reg_b = in_b;
    case (ctrl)
      2'b00: begin //highlight g
//        out_reg_r = ((greeness > thresh_g)) ? (in_r) : gs;
//        out_reg_g = ((greeness > thresh_g)) ? (in_g) : gs;
//        out_reg_b = ((greeness > thresh_g)) ? (in_b) : gs;
			if(greeness > thresh_g) begin
				out_reg_r = in_r;
				out_reg_g = in_g;
				out_reg_b = in_b;

			end else begin
				out_reg_r = gs;
				out_reg_g = gs;
				out_reg_b = gs;
			end
      end
      2'b01: begin //highlight r
        
//		  out_reg_r = ((redness > thresh_r)) ? (in_r) : gs;
//        out_reg_g = ((redness > thresh_r)) ? (in_g) : gs;
//        out_reg_b = ((redness > thresh_r)) ? (in_b) : gs;
			if(redness > thresh_r) begin
				out_reg_r = in_r;
				out_reg_g = in_g;
				out_reg_b = in_b;

			end else begin
				out_reg_r = gs;
				out_reg_g = gs;
				out_reg_b = gs;
			end
      end
      2'b10: begin //highlight b
//        out_reg_r = ((blueness > thresh_b)) ? (in_r) : gs;
//        out_reg_g = ((blueness > thresh_b)) ? (in_g) : gs;
//        out_reg_b = ((blueness > thresh_b)) ? (in_b) : gs;
			if(blueness > thresh_b) begin
				out_reg_r = in_r;
				out_reg_g = in_g;
				out_reg_b = in_b;

			end else begin
				out_reg_r = gs;
				out_reg_g = gs;
				out_reg_b = gs;
			end
      end
		default :begin
			out_reg_r = in_r;
        out_reg_g = in_g;
        out_reg_b = in_b;
		  end
    endcase
  end
  always @(posedge clk) begin
	ctrl <= #1 ctrl_c;
  end
  
endmodule
