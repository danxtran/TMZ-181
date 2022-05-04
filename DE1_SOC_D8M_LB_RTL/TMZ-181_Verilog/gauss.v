module gauss(
input clk,
input [7:0] r, b , g,
input en_gauss5x5,
input [39:0] gauss_coef,
input [12:0] col,
input buff_en,
input shift_en,
output reg [7:0] out_r, out_g, out_b

);


reg [20:0] tmp_1[2:0]; //, tmp_g1, tmp_b1;
reg [7:0] buff [639:0] [2:0];
reg [7:0] shift [10:0] [639:0] [2:0];
saturate satr(.in(tmp_1[0][17:8]), .out(gauss_r));
saturate satb(.in(tmp_1[1][17:8]), .out(gauss_g));
saturate satg(.in(tmp_1[2][17:8]), .out(gauss_b));
wire [7:0] gauss_r, gauss_g, gauss_b;

integer color, column;
integer temp1, temp2, temp3, temp4;
reg [7:0] mem[4:0][4:0];

always @(*) begin
	out_r = gauss_r;
	out_g = gauss_g;
	out_b = gauss_b;
	if(en_gauss5x5 == 1'b1) begin
		out_r = gauss_r;
		out_g = gauss_g;
		out_b = gauss_b;
	end
end
always @(posedge clk) begin
	for(temp3 = 0; temp3 <= 2; temp3 = temp3 + 1) begin
		tmp_1[temp3] = 21'b0;
		for(temp2 = 0; temp2 <= 4; temp2 = temp2 + 1) begin
//			for (temp1 = 0; temp1 <= 4; temp1 = temp1 + 1)begin
			tmp_1[temp3] = tmp_1[temp3] + 
						mem[temp2][0] * shift[10][col - 2][temp3] + 
						mem[temp2][1] * shift[10][col - 1][temp3] + 
						mem[temp2][2] * shift[10][col][temp3] + 
						mem[temp2][3] * shift[10][col + 1][temp3] + 
						mem[temp2][4] * shift[10][col + 2][temp3];
							
//			end
		end
	end

//	for(temp4 = 0; temp4 <= 2; temp4 = temp4 + 1)begin
//		tmp_2[temp4] = (tmp_1[temp4] * 8'b0000101);
//	end

//	8'b00000100 * shift[9][col - 2][0] + 
//	8'b00001111 * shift[9][col - 1][0] + 
//	8'b00011000 * shift[9][col][0] + 
//	8'b00001111 * shift[9][col + 1][0] + 
//	8'b00000100 * shift[9][col + 2][0] + 
//	8'b00000110 * shift[8][col - 2][0] + 
//	8'b00011000 * shift[8][col - 1][0] + 
//	8'b00100110 * shift[8][col][0] + 
//	8'b00011000 * shift[8][col + 1][0] + 
//	8'b00000110 * shift[8][col + 2][0] + 
//	8'b00000100 * shift[7][col - 2][0] + 
//	8'b00001111 * shift[7][col - 1][0] + 
//	8'b00011000 * shift[7][col][0] + 
//	8'b00001111 * shift[7][col + 1][0] + 
//	8'b00000100 * shift[7][col + 2][0] + 
//	8'b00000001 * shift[6][col - 2][0] + 
//	8'b00000100 * shift[6][col - 1][0] + 
//	8'b00000110 * shift[6][col][0] + 
//	8'b00000100 * shift[6][col + 1][0] + 
//	8'b00000001 * shift[6][col + 2][0];
//	tmp_g1 = 8'b00000001 * shift[10][col - 2][1] + 
//	8'b00000100 * shift[10][col - 1][1] + 
//	8'b00000110 * shift[10][col][1] + 
//	8'b00000100 * shift[10][col + 1][1] + 
//	8'b00000001 * shift[10][col + 2][1] + 
//	8'b00000100 * shift[9][col - 2][1] + 
//	8'b00001111 * shift[9][col - 1][1] + 
//	8'b00011000 * shift[9][col][1] + 
//	8'b00001111 * shift[9][col + 1][1] + 
//	8'b00000100 * shift[9][col + 2][1] + 
//	8'b00000110 * shift[8][col - 2][1] + 
//	8'b00011000 * shift[8][col - 1][1] + 
//	8'b00100110 * shift[8][col][1] + 
//	8'b00011000 * shift[8][col + 1][1] + 
//	8'b00000110 * shift[8][col + 2][1] + 
//	8'b00000100 * shift[7][col - 2][1] + 
//	8'b00001111 * shift[7][col - 1][1] + 
//	8'b00011000 * shift[7][col][1] + 
//	8'b00001111 * shift[7][col + 1][1] + 
//	8'b00000100 * shift[7][col + 2][1] + 
//	8'b00000001 * shift[6][col - 2][1] + 
//	8'b00000100 * shift[6][col - 1][1] + 
//	8'b00000110 * shift[6][col][1] + 
//	8'b00000100 * shift[6][col + 1][1] + 
//	8'b00000001 * shift[6][col + 2][1];
//	tmp_g2 = (tmp_g1 * 8'b0000101);
//	tmp_b1 = 8'b00000001 * shift[10][col - 2][2] + 
//	8'b00000100 * shift[10][col - 1][2] + 
//	8'b00000110 * shift[10][col][2] + 
//	8'b00000100 * shift[10][col + 1][2] + 
//	8'b00000001 * shift[10][col + 2][2] + 
//	8'b00000100 * shift[9][col - 2][2] + 
//	8'b00001111 * shift[9][col - 1][2] + 
//	8'b00011000 * shift[9][col][2] + 
//	8'b00001111 * shift[9][col + 1][2] + 
//	8'b00000100 * shift[9][col + 2][2] + 
//	8'b00000110 * shift[8][col - 2][2] + 
//	8'b00011000 * shift[8][col - 1][2] + 
//	8'b00100110 * shift[8][col][2] + 
//	8'b00011000 * shift[8][col + 1][2] + 
//	8'b00000110 * shift[8][col + 2][2] + 
//	8'b00000100 * shift[7][col - 2][2] + 
//	8'b00001111 * shift[7][col - 1][2] + 
//	8'b00011000 * shift[7][col][2] + 
//	8'b00001111 * shift[7][col + 1][2] + 
//	8'b00000100 * shift[7][col + 2][2] + 
//	8'b00000001 * shift[6][col - 2][2] + 
//	8'b00000100 * shift[6][col - 1][2] + 
//	8'b00000110 * shift[6][col][2] + 
//	8'b00000100 * shift[6][col + 1][2] + 
//	8'b00000001 * shift[6][col + 2][2];
//	tmp_b2 = (tmp_b1 * 8'b0000101);

end
always @(posedge clk) begin
	if( buff_en == 1'b1) begin
		buff[col][0] <= #1 r;
		buff[col][1] <= #1 g;
		buff[col][2] <= #1 b;
	end
	if(shift_en == 1'b1) begin
		for(color = 0; color < 3; color = color + 1)begin
			for(column = 0; column < 640; column = column + 1) begin
				shift[0][column][color] <= #1 buff[column][color];
				shift[1][column][color] <= #1 shift[0][column][color];
				shift[2][column][color] <= #1 shift[1][column][color];
				shift[3][column][color] <= #1 shift[2][column][color];
				shift[4][column][color] <= #1 shift[3][column][color];
				shift[5][column][color] <= #1 shift[4][column][color];
				shift[6][column][color] <= #1 shift[5][column][color];
				shift[7][column][color] <= #1 shift[6][column][color];
				shift[8][column][color] <= #1 shift[7][column][color];
				shift[9][column][color] <= #1 shift[8][column][color];
				shift[10][column][color] <= #1 shift[9][column][color];
			end
		end
	end
	
end

	initial begin 
		mem[0][0] = 8'b00001001;
		mem[0][1] = 8'b00001010;
		mem[0][2] = 8'b00001010;
		mem[0][3] = 8'b00001010;
		mem[0][4] = 8'b00001001;
		mem[1][0] = 8'b00001010;
		mem[1][1] = 8'b00001011;
		mem[1][2] = 8'b00001011;
		mem[1][3] = 8'b00001011;
		mem[1][4] = 8'b00001010;
		mem[2][0] = 8'b00001010;
		mem[2][1] = 8'b00001011;
		mem[2][2] = 8'b00001011;
		mem[2][3] = 8'b00001011;
		mem[2][4] = 8'b00001010;
		mem[3][0] = 8'b00001010;
		mem[3][1] = 8'b00001011;
		mem[3][2] = 8'b00001011;
		mem[3][3] = 8'b00001011;
		mem[3][4] = 8'b00001010;
		mem[4][0] = 8'b00001001;
		mem[4][1] = 8'b00001010;
		mem[4][2] = 8'b00001010;
		mem[4][3] = 8'b00001010;
		mem[4][4] = 8'b00001001;
	end
	

endmodule

