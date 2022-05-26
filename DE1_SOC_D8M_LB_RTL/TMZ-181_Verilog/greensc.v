module greensc (
  input clk,
  input [12:0] row,
  input [12:0] col,
  input gsc_en,
  input [1:0] bg_sel,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in,
  output reg [23:0] pass_thru
);

reg [23:0] pixel_out_c;

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
		pixel_out_c = pixel_in;
		if(gsc_en == 1'b1)begin
			if (pixel_in[23:15] >= 9'd90 && pixel_in[23:15] <= 9'd150 && pixel_in[14:8] >= 7'd50) begin
				case (bg_sel)
					2'b01: begin
								pixel_out_c = {bg1, 15'b111_1111_1111_1111};
							 end
					2'b10: begin
								pixel_out_c = {bg2, 15'b111_1111_1111_1111};
							 end
					2'b11: begin
								pixel_out_c = {bg3, 15'b111_1111_1111_1111};
							 end
					default: begin
								pixel_out_c = {bg0, 15'b111_1111_1111_1111};
							 end
				endcase
			end
		end
  end
  
always @(posedge clk) begin
  pixel_out <= #1 pixel_out_c;
  pass_thru <= #1 pass_in; 
end

endmodule
