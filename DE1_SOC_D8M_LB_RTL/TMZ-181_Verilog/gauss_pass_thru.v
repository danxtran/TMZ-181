module gauss_pass_thru (
  input clk,
  input [12:0] col,
  input [12:0] x_count,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

wire row_shift_en0, row_shift_en1, row_shift_en2, row_shift_en3, row_shift_en4, row_shift_en5;
row_shift_en_gen en_gen0 (col, x_count, row_shift_en0, row_shift_en1, row_shift_en2, row_shift_en3, row_shift_en4, row_shift_en5, , , , , ); 

wire [9:0] adr0, adr1, adr2, adr3, adr4, adr5;
shift_adr shiftadrs0 (col[9:0], 10'd0639, adr0, adr1, adr2, adr3, adr4, adr5, adr6, , , , );


wire [23:0] r0c0, r0c1, r0c2, r0c3, r0c4, r0c5, r0c6, r0c7, r0c8, r0c9, r0c10, 
				r1c0, r1c1, r1c2, r1c3, r1c4, r1c5, r1c6, r1c7, r1c8, r1c9, r1c10, 
				r2c0, r2c1, r2c2, r2c3, r2c4, r2c5, r2c6, r2c7, r2c8, r2c9, r2c10, 
				r3c0, r3c1, r3c2, r3c3, r3c4, r3c5, r3c6, r3c7, r3c8, r3c9, r3c10, 
				r4c0, r4c1, r4c2, r4c3, r4c4, r4c5, r4c6, r4c7, r4c8, r4c9, r4c10, 
				r5c0, r5c1, r5c2, r5c3, r5c4, r5c5;

assign pass_thru = r5c5;

wire [23:0] row0_out, row1_out, row2_out, row3_out, row4_out, row5_out;
wire [23:0] shift_reg_in0, shift_reg_in1, shift_reg_in2, shift_reg_in3, shift_reg_in4, shift_reg_in5;
assign shift_reg_in0 = pass_in;

wire shift_en = row_shift_en0;

rowRam r0 (.clk(clk), .wr_en(row_shift_en0), .addr(adr0), .rd_adr(adr1), .rd_adr2(adr1), .data_in(pass_in), .data_out(row0_out), .data_out2());
rowRam r1 (.clk(clk), .wr_en(row_shift_en1), .addr(adr1), .rd_adr(adr2), .rd_adr2(adr0), .data_in(row0_out), .data_out(row1_out), .data_out2(shift_reg_in1));
rowRam r2 (.clk(clk), .wr_en(row_shift_en2), .addr(adr2), .rd_adr(adr3), .rd_adr2(adr0), .data_in(row1_out), .data_out(row2_out), .data_out2(shift_reg_in2));
rowRam r3 (.clk(clk), .wr_en(row_shift_en3), .addr(adr3), .rd_adr(adr4), .rd_adr2(adr0), .data_in(row2_out), .data_out(row3_out), .data_out2(shift_reg_in3));
rowRam r4 (.clk(clk), .wr_en(row_shift_en4), .addr(adr4), .rd_adr(adr5), .rd_adr2(adr0), .data_in(row3_out), .data_out(row4_out), .data_out2(shift_reg_in4));
rowRam r5 (.clk(clk), .wr_en(row_shift_en5), .addr(adr5), .rd_adr(adr6), .rd_adr2(adr0), .data_in(row4_out), .data_out(row5_out), .data_out2(shift_reg_in5));


shift_reg c0 (.pixel(shift_reg_in0), .clk(clk), .shift_en(shift_en),.reg_0(r0c0), .reg_1(r0c1), .reg_2(r0c2), .reg_3(r0c3), .reg_4(r0c4),
					.reg_5(r0c5), .reg_6(r0c6), .reg_7(r0c7), .reg_8(r0c8), .reg_9(r0c9), .reg_10(r0c10));
shift_reg c1 (.pixel(shift_reg_in1), .clk(clk), .shift_en(shift_en),.reg_0(r1c0), .reg_1(r1c1), .reg_2(r1c2), .reg_3(r1c3), .reg_4(r1c4),
					.reg_5(r1c5), .reg_6(r1c6), .reg_7(r1c7), .reg_8(r1c8), .reg_9(r1c9), .reg_10(r1c10));
shift_reg c2 (.pixel(shift_reg_in2), .clk(clk), .shift_en(shift_en),.reg_0(r2c0), .reg_1(r2c1), .reg_2(r2c2), .reg_3(r2c3), .reg_4(r2c4),
					.reg_5(r2c5), .reg_6(r2c6), .reg_7(r2c7), .reg_8(r2c8), .reg_9(r2c9), .reg_10(r2c10));
shift_reg c3 (.pixel(shift_reg_in3), .clk(clk), .shift_en(shift_en),.reg_0(r3c0), .reg_1(r3c1), .reg_2(r3c2), .reg_3(r3c3), .reg_4(r3c4),
					.reg_5(r3c5), .reg_6(r3c6), .reg_7(r3c7), .reg_8(r3c8), .reg_9(r3c9), .reg_10(r3c10));
shift_reg c4 (.pixel(shift_reg_in4), .clk(clk), .shift_en(shift_en),.reg_0(r4c0), .reg_1(r4c1), .reg_2(r4c2), .reg_3(r4c3), .reg_4(r4c4),
					.reg_5(r4c5), .reg_6(r4c6), .reg_7(r4c7), .reg_8(r4c8), .reg_9(r4c9), .reg_10(r4c10));
shift_reg c5 (.pixel(shift_reg_in5), .clk(clk), .shift_en(shift_en),.reg_0(r5c0), .reg_1(r5c1), .reg_2(r5c2), .reg_3(r5c3), .reg_4(r5c4),
					.reg_5(r5c5));

endmodule
