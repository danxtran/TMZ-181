`timescale 1 ns/10 ps

module gauss_tb;
	parameter MEM_SIZE = 307200; // 640x480 (HxV)
	parameter PIXEL_SIZE = 8; // 8 bits (1 byte)
	reg [PIXEL_SIZE - 1:0] mem_R [MEM_SIZE - 1:0];
	reg [PIXEL_SIZE - 1:0] mem_G [MEM_SIZE - 1:0];
	reg [PIXEL_SIZE - 1:0] mem_B [MEM_SIZE - 1:0];
	reg clock;	
	// UUT here
	
	initial begin
		$readmemh("mem_R.txt", mem_R);
		$readmemh("mem_G.txt", mem_G);
		$readmemh("mem_B.txt", mem_B);
	end
	always begin
		if(reset == 1'b1)begin
			clock = 1'b0;
			#1;
		end else begin
			#100;
			clock = ~clock;
		end
	end

endmodule

