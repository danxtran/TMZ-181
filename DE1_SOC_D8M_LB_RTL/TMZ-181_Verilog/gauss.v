module gauss(
input clk,
input [5119:0] row_pixel1,
input [5119:0] row_pixel2,
input [5119:0] row_pixel3,
input [5119:0] row_pixel4,
input [5119:0] row_pixel5,
input en_gauss5x5,
input [39:0] gauss_coef,
input [12:0] col,
output reg [7:0] out_pixel
);


reg [20:0] tmp1;
reg [12:0] tmp2;
saturate sat(.in(tmp2[9:0]), .out(out_pixel));
always @(*)begin

	tmp1 = (8'h01*row_pixel1[(col - 2) +: 8])
	+ (8'h03*row_pixel1[(col - 1) +: 8]) 
	+ (8'h04*row_pixel1[(col) +: 8]) 
	+ (8'h03*row_pixel1[(col + 1) +: 8]) 
	+ (8'h03*row_pixel1[(col + 2) +: 8])  
	
	+ (8'h03*row_pixel2[(col - 2) +: 8])
	+ (8'h0c*row_pixel2[(col - 1) +: 8]) 
	+ (8'h13*row_pixel2[(col) +: 8]) 
	+ (8'h0c*row_pixel2[(col + 1) +: 8]) 
	+ (8'h03*row_pixel2[(col + 2) +: 8])

	+ (8'h04*row_pixel3[(col - 2) +: 8])
	+ (8'h13*row_pixel3[(col - 1) +: 8]) 
	+ (8'h20*row_pixel3[(col) +: 8]) 
	+ (8'h13*row_pixel3[(col + 1) +: 8]) 
	+ (8'h04*row_pixel3[(col + 2) +: 8])	

	+ (8'h03*row_pixel4[(col - 2) +: 8])
	+ (8'h0c*row_pixel4[(col - 1) +: 8]) 
	+ (8'h13*row_pixel4[(col) +: 8]) 
	+ (8'h0c*row_pixel4[(col + 1) +: 8]) 
	+ (8'h03*row_pixel4[(col + 2) +: 8])

	+ (8'h01*row_pixel5[(col - 2) +: 8])
	+ (8'h03*row_pixel5[(col - 1) +: 8]) 
	+ (8'h04*row_pixel5[(col) +: 8]) 
	+ (8'h03*row_pixel5[(col + 1) +: 8]) 
	+ (8'h01*row_pixel5[(col + 2) +: 8]);
	
	tmp2 = (tmp1 * 4'h4) >> 12;

end


endmodule

