module gauss(
input clk,
input [5119:0] row_pixel,
input en_gauss5x5,
input [39:0] gauss_coef,
input [12:0] col,
output reg [5119:0] out_pixel
);

reg [2:0] i;
reg [15:0] tmp;
reg [16:0] acc;
always @(*)begin
	if (i == 6) begin
		i = 0;
		out_pixel[8*(col - 25) +: 8] = acc; // subtract 25, since we have to 
		acc = 17'd0;
	end
	
	tmp = row_pixel[8*col +: 8] * gauss_coef[8*i +: 8]; // multiply the current image pixel with gauss coefficient
	
	acc = acc + tmp; // accumulate the sum of the 5x5 area
	i = i + 1; // move the gauss coeff 
	
end

always @(posedge clk)begin

end

endmodule

