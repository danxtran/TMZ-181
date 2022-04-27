module rom11x11(
	input clk,
	input rd_en,
	input [6:0] addr, // 11 * 11 = 121 values, log_2(121) = ceil(ans) = 7 bits
	output reg [5119:0] data_out
);
	initial begin 
		mem[0] = 24'h1;
		mem[1] = 24'h1;
		mem[2] = 24'h2;
		mem[3] = 24'h3;
		mem[4] = 24'h4;
		mem[5] = 24'h4;
		mem[6] = 24'h4;
		mem[7] = 24'h3;
		mem[8] = 24'h2;
		mem[9] = 24'h1;
		mem[10] = 24'h1;
		mem[11] = 24'h1;
		mem[12] = 24'h2;
		mem[13] = 24'h4;
		mem[14] = 24'h6;
		mem[15] = 24'h8;
		mem[16] = 24'h9;
		mem[17] = 24'h8;
		mem[18] = 24'h6;
		mem[19] = 24'h4;
		mem[20] = 24'h2;
		mem[21] = 24'h1;
		mem[22] = 24'h2;
		mem[23] = 24'h4;
		mem[24] = 24'h8;
		mem[25] = 24'hb;
		mem[26] = 24'he;
		mem[27] = 24'h10;
		mem[28] = 24'he;
		mem[29] = 24'hb;
		mem[30] = 24'h8;
		mem[31] = 24'h4;
		mem[32] = 24'h2;
		mem[33] = 24'h3;
		mem[34] = 24'h6;
		mem[35] = 24'hb;
		mem[36] = 24'h11;
		mem[37] = 24'h15;
		mem[38] = 24'h17;
		mem[39] = 24'h15;
		mem[40] = 24'h11;
		mem[41] = 24'hb;
		mem[42] = 24'h6;
		mem[43] = 24'h3;
		mem[44] = 24'h4;
		mem[45] = 24'h8;
		mem[46] = 24'he;
		mem[47] = 24'h15;
		mem[48] = 24'h1b;
		mem[49] = 24'h1e;
		mem[50] = 24'h1b;
		mem[51] = 24'h15;
		mem[52] = 24'he;
		mem[53] = 24'h8;
		mem[54] = 24'h4;
		mem[55] = 24'h4;
		mem[56] = 24'h9;
		mem[57] = 24'h10;
		mem[58] = 24'h17;
		mem[59] = 24'h1e;
		mem[60] = 24'h20;
		mem[61] = 24'h1e;
		mem[62] = 24'h17;
		mem[63] = 24'h10;
		mem[64] = 24'h9;
		mem[65] = 24'h4;
		mem[66] = 24'h4;
		mem[67] = 24'h8;
		mem[68] = 24'he;
		mem[69] = 24'h15;
		mem[70] = 24'h1b;
		mem[71] = 24'h1e;
		mem[72] = 24'h1b;
		mem[73] = 24'h15;
		mem[74] = 24'he;
		mem[75] = 24'h8;
		mem[76] = 24'h4;
		mem[77] = 24'h3;
		mem[78] = 24'h6;
		mem[79] = 24'hb;
		mem[80] = 24'h11;
		mem[81] = 24'h15;
		mem[82] = 24'h17;
		mem[83] = 24'h15;
		mem[84] = 24'h11;
		mem[85] = 24'hb;
		mem[86] = 24'h6;
		mem[87] = 24'h3;
		mem[88] = 24'h2;
		mem[89] = 24'h4;
		mem[90] = 24'h8;
		mem[91] = 24'hb;
		mem[92] = 24'he;
		mem[93] = 24'h10;
		mem[94] = 24'he;
		mem[95] = 24'hb;
		mem[96] = 24'h8;
		mem[97] = 24'h4;
		mem[98] = 24'h2;
		mem[99] = 24'h1;
		mem[100] = 24'h2;
		mem[101] = 24'h4;
		mem[102] = 24'h6;
		mem[103] = 24'h8;
		mem[104] = 24'h9;
		mem[105] = 24'h8;
		mem[106] = 24'h6;
		mem[107] = 24'h4;
		mem[108] = 24'h2;
		mem[109] = 24'h1;
		mem[110] = 24'h1;
		mem[111] = 24'h1;
		mem[112] = 24'h2;
		mem[113] = 24'h3;
		mem[114] = 24'h4;
		mem[115] = 24'h4;
		mem[116] = 24'h4;
		mem[117] = 24'h3;
		mem[118] = 24'h2;
		mem[119] = 24'h1;
		mem[120] = 24'h1;
	end
	reg [5119:0] mem[127:0];
	always @(posedge clk) begin
		if(rd_en == 1'b1) begin
			data_out <= #1 mem[addr];
		end
	end


endmodule
