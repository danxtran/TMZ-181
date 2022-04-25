

module buffer(
input clk,
input rst,
input wr_en,
input [7:0] pixel,
input [12:0] col,
output reg [5119:0] pixel_row/*, pixel_row_2, pixel_row_3, pixel_row_4, pixel_row_5, 
						pixel_row_6, pixel_row_7, pixel_row_8, pixel_row_9, pixel_row_10, pixel_row_11
						*/
);

reg [5119:0] pixel_row_c;

always @(*) begin
  case (wr_en)
    1'b1: begin pixel_row_c [8*col +: 8] = pixel; end
	 default begin pixel_row_c = pixel_row; end
  endcase
end

always @(posedge clk) begin
  if (wr_en == 1'b1) begin
    pixel_row <= #1 pixel_row_c;
  end
end



endmodule
