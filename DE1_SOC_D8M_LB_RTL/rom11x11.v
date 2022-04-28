module rom11x11(
	input clk,
	input rd_en,
	input [6:0] addr, // 11 * 11 = 121 values, log_2(121) = ceil(ans) = 7 bits
	output reg [87:0] data_out
);
	initial begin 
		mem[0] = 88'h0101020304040403020101;
		mem[1] = 88'h0102040608090806040201;
		mem[2] = 88'h0204080b0e100e0b080402;
		mem[3] = 88'h03060b11151715110b0603;
		mem[4] = 88'h04080e151b1e1b150e0804;
		mem[5] = 88'h040910171e201e17100904;
		mem[6] = 88'h04080e151b1e1b150e0804;
		mem[7] = 88'h03060b11151715110b0603;
		mem[8] = 88'h0204080b0e100e0b080402;
		mem[9] = 88'h0102040608090806040201;
		mem[10] = 88'h0101020304040403020101;
	end
	reg [87:0] mem[10:0];
	always @(posedge clk) begin
		if(rd_en == 1'b1) begin
			data_out <= #1 mem[addr];
		end
	end


endmodule
