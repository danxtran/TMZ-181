module rom5x5(
	input clk,
	input rd_en,
	input [2:0] addr, // 5 total addresses, 2^3 = 8 bits is good to cover the addresses
	output reg [39:0] data_out // 5 coeff per row * 8 bits to represent value = 40 bits 
);
	initial begin 
		mem[0] = 40'h0103040301;
		mem[1] = 40'h030c130c03;
		mem[2] = 40'h0413201304;
		mem[3] = 40'h030c130c03;
		mem[4] = 40'h0103040301;
	end
	reg [39:0] mem[4:0];
	always @(posedge clk) begin
		if(rd_en == 1'b1) begin
			data_out <= #1 mem[addr];
		end
	end


endmodule
