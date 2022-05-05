module rowRam(
	input clk,
	input wr_en,
	input [9:0] addr,
	input [9:0] rd_adr,
	input [23:0] data_in,
	output reg [23:0] data_out
);
	reg [23:0] mem [639:0];
//	assign data_out = mem[addr];
	
	always @(posedge clk) begin
		if(wr_en == 1'b1) begin
			mem[addr] <= #1 data_in;
		end
		data_out <= #1 mem[rd_adr];
	end
	
endmodule
