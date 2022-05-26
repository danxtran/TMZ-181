module greensc (
  input clk,
  input [12:0] row,
  input [12:0] col,
  input gsc_en,
  input bg_sel,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

assign pass_thru = pass_in;

wire [13:0] sum0 = row + col;
wire [13:0] sum1 = row - col + 10'd720;
wire [13:0] sum2 = row;
wire [13:0] sum3 = col;
wire [8:0] bg0, bg1, bg2, bg3;

mod360 mbg0 (sum0[10:0], bg0);
mod360 mbg1 (sum1[10:0], bg1);
mod360 mbg2 (sum2[10:0], bg2);
mod360 mbg3 (sum3[10:0], bg3);
 
  always @(*)begin
//		if(gsc_en == 1'b1)begin
//			if (pixel_in[23:15] >= 9'd90 && pixel_in[23:15] <= 9'd150) begin
//				case (bg_sel)
//					2'b01: begin
//								pixel_out = {bg1, 15'b111_1111_1111_1111};
//							 end
//					2'b10: begin
//								pixel_out = {bg2, 15'b111_1111_1111_1111};
//							 end
//					2'b11: begin
//								pixel_out = {bg3, 15'b111_1111_1111_1111};
//							 end
//					default: begin
//								pixel_out = {bg0, 15'b111_1111_1111_1111};
//							 end
//				endcase
//			end
//			else if (pixel_in[23:15] < 9'd90 || pixel_in[23:15] > 9'd150) begin
//			   pixel_out = pixel_in;
//		   end
//		end
//		else if (gsc_en == 1'b0) begin
			pixel_out = pixel_in;
//		end
  end
endmodule
