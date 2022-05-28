`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module shift_reg(
input [23:0] pixel,
input clk,
input shift_en,
output reg [23:0] reg_0, reg_1, reg_2, reg_3, reg_4, reg_5, 
						reg_6, reg_7, reg_8, reg_9, reg_10);
					
always @(posedge clk)begin
	if(shift_en) begin
		reg_0 <= #1 pixel;
		reg_1 <= #1 reg_0;
		reg_2 <= #1 reg_1;
		reg_3 <= #1 reg_2;
		reg_4 <= #1 reg_3;
		reg_5 <= #1 reg_4;
		reg_6 <= #1 reg_5;
		reg_7 <= #1 reg_6;
		reg_8 <= #1 reg_7;
		reg_9 <= #1 reg_8;
		reg_10 <= #1 reg_9;
	end
end


endmodule
