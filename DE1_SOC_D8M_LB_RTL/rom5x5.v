module rom5x5(
	input clk,
	input rd_en,
	input [4:0] addr, // 5 * 5 = 25 values, log_2(25) = 4.6 ceil(ans) = 5 bits
	output reg [5119:0] data_out
);
	initial begin 
		mem[0] = 24'h1;
		mem[1] = 24'h3;
		mem[2] = 24'h4;
		mem[3] = 24'h3;
		mem[4] = 24'h1;
		mem[5] = 24'h3;
		mem[6] = 24'hc;
		mem[7] = 24'h13;
		mem[8] = 24'hc;
		mem[9] = 24'h3;
		mem[10] = 24'h4;
		mem[11] = 24'h13;
		mem[12] = 24'h20;
		mem[13] = 24'h13;
		mem[14] = 24'h4;
		mem[15] = 24'h3;
		mem[16] = 24'hc;
		mem[17] = 24'h13;
		mem[18] = 24'hc;
		mem[19] = 24'h3;
		mem[20] = 24'h1;
		mem[21] = 24'h3;
		mem[22] = 24'h4;
		mem[23] = 24'h3;
		mem[24] = 24'h1;
	end
	reg [5119:0] mem[31:0];
	always @(posedge clk) begin
		if(rd_en == 1'b1) begin
			data_out <= #1 mem[addr];
		end
	end


endmodule
