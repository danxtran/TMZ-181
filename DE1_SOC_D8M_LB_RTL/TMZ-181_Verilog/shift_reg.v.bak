module shift_reg(
input [5119:0] pixel_row,
input clk,
input shift_en,
output reg [5119:0] reg_1, reg_2, reg_3, reg_4, reg_5, 
						reg_6, reg_7, reg_8, reg_9, reg_10, reg_11);
					
always @(posedge clk)begin
	if(shift_en) begin
		reg_1 <= #1 pixel_row;
		reg_2 <= #1 reg_1;
		reg_3 <= #1 reg_2;
		reg_4 <= #1 reg_3;
		reg_5 <= #1 reg_4;
		reg_6 <= #1 reg_5;
		reg_7 <= #1 reg_6;
		reg_8 <= #1 reg_7;
		reg_9 <= #1 reg_8;
		reg_10 <= #1 reg_9;
		reg_11 <= #1 reg_10;
	end
end


endmodule
