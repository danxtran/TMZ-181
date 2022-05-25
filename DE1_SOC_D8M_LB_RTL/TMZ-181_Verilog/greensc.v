module greensc (
  input [12:0] row,
  input [12:0] col,
  input gsc_en,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in,
  output [23:0] pass_thru
);
	
wire [8:0] background;
wire [13:0] sumrc = row + col; 
mod mod360(.in(sumrc[10:0]),.out(background));
	

assign pass_thru = pass_in;
 
always @(*)begin
  pixel_out = pixel_in;
  if(gsc_en == 1'b1)begin
    if(pixel_in[23:15] >= 9'd90 && pixel_in[23:15] <= 9'd150) begin
      pixel_out[23:15] = background;
      pixel_out[14:0] = 15'b1111_1111_1111_111;
    end 
  end
end
endmodule
