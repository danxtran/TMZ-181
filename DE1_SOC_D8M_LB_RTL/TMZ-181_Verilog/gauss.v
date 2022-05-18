`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

(* multstyle = "logic" *)
module gauss(
  input clk,
  input rst,
  input [7:0] r, b , g,
  input [12:0] col,
  input [12:0] x_count,
  input [3:0] filt_sel,
  output [7:0] outR, outG, outB,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

gauss_pass_thru pass0 (clk, col, x_count, pass_in, pass_thru);

reg [7:0] mem [10:0][10:0];
reg [1:0] ctrl_c, ctrl;

wire [23:0] pixel_in = {r, g, b};

wire row_shift_en0, row_shift_en1, row_shift_en2, row_shift_en3, row_shift_en4, row_shift_en5, row_shift_en6, row_shift_en7, row_shift_en8, row_shift_en9, row_shift_en10;
row_shift_en_gen en_gen0 (col, x_count, row_shift_en0, row_shift_en1, row_shift_en2, row_shift_en3, row_shift_en4, row_shift_en5, row_shift_en6, row_shift_en7, row_shift_en8, row_shift_en9, row_shift_en10); 

wire [9:0] adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8, adr9, adr10;
shift_adr shiftadrs0 (col[9:0], 10'd0639, adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8, adr9, adr10);




wire [23:0] r0c0, r0c1, r0c2, r0c3, r0c4, r0c5, r0c6, r0c7, r0c8, r0c9, r0c10, 
				r1c0, r1c1, r1c2, r1c3, r1c4, r1c5, r1c6, r1c7, r1c8, r1c9, r1c10, 
				r2c0, r2c1, r2c2, r2c3, r2c4, r2c5, r2c6, r2c7, r2c8, r2c9, r2c10, 
				r3c0, r3c1, r3c2, r3c3, r3c4, r3c5, r3c6, r3c7, r3c8, r3c9, r3c10, 
				r4c0, r4c1, r4c2, r4c3, r4c4, r4c5, r4c6, r4c7, r4c8, r4c9, r4c10, 
				r5c0, r5c1, r5c2, r5c3, r5c4, r5c5, r5c6, r5c7, r5c8, r5c9, r5c10, 
				r6c0, r6c1, r6c2, r6c3, r6c4, r6c5, r6c6, r6c7, r6c8, r6c9, r6c10, 
				r7c0, r7c1, r7c2, r7c3, r7c4, r7c5, r7c6, r7c7, r7c8, r7c9, r7c10, 
				r8c0, r8c1, r8c2, r8c3, r8c4, r8c5, r8c6, r8c7, r8c8, r8c9, r8c10, 
				r9c0, r9c1, r9c2, r9c3, r9c4, r9c5, r9c6, r9c7, r9c8, r9c9, r9c10, 
				r10c0, r10c1, r10c2, r10c3, r10c4, r10c5, r10c6, r10c7, r10c8, r10c9, r10c10;

			
reg [7:0]  coeff_r0c0, coeff_r0c1, coeff_r0c2, coeff_r0c3, coeff_r0c4, coeff_r0c5, coeff_r0c6, coeff_r0c7, coeff_r0c8, coeff_r0c9, coeff_r0c10, 
				coeff_r1c0, coeff_r1c1, coeff_r1c2, coeff_r1c3, coeff_r1c4, coeff_r1c5, coeff_r1c6, coeff_r1c7, coeff_r1c8, coeff_r1c9, coeff_r1c10, 
				coeff_r2c0, coeff_r2c1, coeff_r2c2, coeff_r2c3, coeff_r2c4, coeff_r2c5, coeff_r2c6, coeff_r2c7, coeff_r2c8, coeff_r2c9, coeff_r2c10, 
				coeff_r3c0, coeff_r3c1, coeff_r3c2, coeff_r3c3, coeff_r3c4, coeff_r3c5, coeff_r3c6, coeff_r3c7, coeff_r3c8, coeff_r3c9, coeff_r3c10, 
				coeff_r4c0, coeff_r4c1, coeff_r4c2, coeff_r4c3, coeff_r4c4, coeff_r4c5, coeff_r4c6, coeff_r4c7, coeff_r4c8, coeff_r4c9, coeff_r4c10, 
				coeff_r5c0, coeff_r5c1, coeff_r5c2, coeff_r5c3, coeff_r5c4, coeff_r5c5, coeff_r5c6, coeff_r5c7, coeff_r5c8, coeff_r5c9, coeff_r5c10, 
				coeff_r6c0, coeff_r6c1, coeff_r6c2, coeff_r6c3, coeff_r6c4, coeff_r6c5, coeff_r6c6, coeff_r6c7, coeff_r6c8, coeff_r6c9, coeff_r6c10, 
				coeff_r7c0, coeff_r7c1, coeff_r7c2, coeff_r7c3, coeff_r7c4, coeff_r7c5, coeff_r7c6, coeff_r7c7, coeff_r7c8, coeff_r7c9, coeff_r7c10, 
				coeff_r8c0, coeff_r8c1, coeff_r8c2, coeff_r8c3, coeff_r8c4, coeff_r8c5, coeff_r8c6, coeff_r8c7, coeff_r8c8, coeff_r8c9, coeff_r8c10, 
				coeff_r9c0, coeff_r9c1, coeff_r9c2, coeff_r9c3, coeff_r9c4, coeff_r9c5, coeff_r9c6, coeff_r9c7, coeff_r9c8, coeff_r9c9, coeff_r9c10, 
				coeff_r10c0, coeff_r10c1, coeff_r10c2, coeff_r10c3, coeff_r10c4, coeff_r10c5, coeff_r10c6, coeff_r10c7, coeff_r10c8, coeff_r10c9, coeff_r10c10;
	

reg [23:0] sumR, sumG, sumB;

saturate satr(.in(sumR[17:8]), .out(outR));
saturate satb(.in(sumG[17:8]), .out(outG));
saturate satg(.in(sumB[17:8]), .out(outB));


wire [23:0] row0_out, row1_out, row2_out, row3_out, row4_out, row5_out, row6_out, row7_out, row8_out, row9_out, row10_out;
wire [23:0] shift_reg_in0, shift_reg_in1, shift_reg_in2, shift_reg_in3, shift_reg_in4, shift_reg_in5, shift_reg_in6, shift_reg_in7, shift_reg_in8, shift_reg_in9, shift_reg_in10;
assign shift_reg_in0 = pixel_in;

wire shift_en = row_shift_en0;

rowRam r0 (.clk(clk), .wr_en(row_shift_en0), .addr(adr0), .rd_adr(adr1), .rd_adr2(adr1), .data_in(pixel_in), .data_out(row0_out), .data_out2());
rowRam r1 (.clk(clk), .wr_en(row_shift_en1), .addr(adr1), .rd_adr(adr2), .rd_adr2(adr0), .data_in(row0_out), .data_out(row1_out), .data_out2(shift_reg_in1));
rowRam r2 (.clk(clk), .wr_en(row_shift_en2), .addr(adr2), .rd_adr(adr3), .rd_adr2(adr0), .data_in(row1_out), .data_out(row2_out), .data_out2(shift_reg_in2));
rowRam r3 (.clk(clk), .wr_en(row_shift_en3), .addr(adr3), .rd_adr(adr4), .rd_adr2(adr0), .data_in(row2_out), .data_out(row3_out), .data_out2(shift_reg_in3));
rowRam r4 (.clk(clk), .wr_en(row_shift_en4), .addr(adr4), .rd_adr(adr5), .rd_adr2(adr0), .data_in(row3_out), .data_out(row4_out), .data_out2(shift_reg_in4));
rowRam r5 (.clk(clk), .wr_en(row_shift_en5), .addr(adr5), .rd_adr(adr6), .rd_adr2(adr0), .data_in(row4_out), .data_out(row5_out), .data_out2(shift_reg_in5));
rowRam r6 (.clk(clk), .wr_en(row_shift_en6), .addr(adr6), .rd_adr(adr7), .rd_adr2(adr0), .data_in(row5_out), .data_out(row6_out), .data_out2(shift_reg_in6));
rowRam r7 (.clk(clk), .wr_en(row_shift_en7), .addr(adr7), .rd_adr(adr8), .rd_adr2(adr0), .data_in(row6_out), .data_out(row7_out), .data_out2(shift_reg_in7));
rowRam r8 (.clk(clk), .wr_en(row_shift_en8), .addr(adr8), .rd_adr(adr9), .rd_adr2(adr0), .data_in(row7_out), .data_out(row8_out), .data_out2(shift_reg_in8));
rowRam r9 (.clk(clk), .wr_en(row_shift_en9), .addr(adr9), .rd_adr(adr10), .rd_adr2(adr0), .data_in(row8_out), .data_out(row9_out), .data_out2(shift_reg_in9));
rowRam r10 (.clk(clk), .wr_en(row_shift_en10), .addr(adr10), .rd_adr(col), .rd_adr2(adr0), .data_in(row9_out), .data_out(row10_out), .data_out2(shift_reg_in10));


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
					.reg_5(r5c5), .reg_6(r5c6), .reg_7(r5c7), .reg_8(r5c8), .reg_9(r5c9), .reg_10(r5c10));
shift_reg c6 (.pixel(shift_reg_in6), .clk(clk), .shift_en(shift_en),.reg_0(r6c0), .reg_1(r6c1), .reg_2(r6c2), .reg_3(r6c3), .reg_4(r6c4),
					.reg_5(r6c5), .reg_6(r6c6), .reg_7(r6c7), .reg_8(r6c8), .reg_9(r6c9), .reg_10(r6c10));
shift_reg c7 (.pixel(shift_reg_in7), .clk(clk), .shift_en(shift_en),.reg_0(r7c0), .reg_1(r7c1), .reg_2(r7c2), .reg_3(r7c3), .reg_4(r7c4),
					.reg_5(r7c5), .reg_6(r7c6), .reg_7(r7c7), .reg_8(r7c8), .reg_9(r7c9), .reg_10(r7c10));
shift_reg c8 (.pixel(shift_reg_in8), .clk(clk), .shift_en(shift_en),.reg_0(r8c0), .reg_1(r8c1), .reg_2(r8c2), .reg_3(r8c3), .reg_4(r8c4),
					.reg_5(r8c5), .reg_6(r8c6), .reg_7(r8c7), .reg_8(r8c8), .reg_9(r8c9), .reg_10(r8c10));
shift_reg c9 (.pixel(shift_reg_in9), .clk(clk), .shift_en(shift_en),.reg_0(r9c0), .reg_1(r9c1), .reg_2(r9c2), .reg_3(r9c3), .reg_4(r9c4),
					.reg_5(r9c5), .reg_6(r9c6), .reg_7(r9c7), .reg_8(r9c8), .reg_9(r9c9), .reg_10(r9c10));
shift_reg c10 (.pixel(shift_reg_in10), .clk(clk), .shift_en(shift_en),.reg_0(r10c0), .reg_1(r10c1), .reg_2(r10c2), .reg_3(r10c3), .reg_4(r10c4),
					.reg_5(r10c5), .reg_6(r10c6), .reg_7(r10c7), .reg_8(r10c8), .reg_9(r10c9), .reg_10(r10c10));

always @(posedge clk) begin
	ctrl <= #1 ctrl_c;
end

always @(*) begin

	if (filt_sel[3] == 1'b1) begin //5x5
		ctrl_c = 2'b01;
	end
	else if (filt_sel[2] == 1'b1) begin // 7x7
		ctrl_c = 2'b00;
	end
	else if (filt_sel[1] == 1'b1) begin //11x11
		ctrl_c = 2'b10;
	end
	else if (filt_sel[0] == 1'b1) begin // Normal
		ctrl_c = 2'b11;
	end
	else begin
		ctrl_c = ctrl;
	end
	if (rst == 1'b1) begin 
		ctrl_c = 2'b11;
	end
end

always @(posedge clk) begin

//------------------------- RED ----------------------
sumR = 24'h000000 + r0c0[23:16] * coeff_r0c0 +r0c1[23:16] * coeff_r0c1 +r0c2[23:16] * coeff_r0c2 +r0c3[23:16] * coeff_r0c3 +r0c4[23:16] * coeff_r0c4 +r0c5[23:16] * coeff_r0c5 +r0c6[23:16] * coeff_r0c6 +r0c7[23:16] * coeff_r0c7 +r0c8[23:16] * coeff_r0c8 +r0c9[23:16] * coeff_r0c9 +r0c10[23:16] * coeff_r0c10 +
r1c0[23:16] * coeff_r1c0 +r1c1[23:16] * coeff_r1c1 +r1c2[23:16] * coeff_r1c2 +r1c3[23:16] * coeff_r1c3 +r1c4[23:16] * coeff_r1c4 +r1c5[23:16] * coeff_r1c5 +r1c6[23:16] * coeff_r1c6 +r1c7[23:16] * coeff_r1c7 +r1c8[23:16] * coeff_r1c8 +r1c9[23:16] * coeff_r1c9 +r1c10[23:16] * coeff_r1c10 +
r2c0[23:16] * coeff_r2c0 +r2c1[23:16] * coeff_r2c1 +r2c2[23:16] * coeff_r2c2 +r2c3[23:16] * coeff_r2c3 +r2c4[23:16] * coeff_r2c4 +r2c5[23:16] * coeff_r2c5 +r2c6[23:16] * coeff_r2c6 +r2c7[23:16] * coeff_r2c7 +r2c8[23:16] * coeff_r2c8 +r2c9[23:16] * coeff_r2c9 +r2c10[23:16] * coeff_r2c10 +
r3c0[23:16] * coeff_r3c0 +r3c1[23:16] * coeff_r3c1 +r3c2[23:16] * coeff_r3c2 +r3c3[23:16] * coeff_r3c3 +r3c4[23:16] * coeff_r3c4 +r3c5[23:16] * coeff_r3c5 +r3c6[23:16] * coeff_r3c6 +r3c7[23:16] * coeff_r3c7 +r3c8[23:16] * coeff_r3c8 +r3c9[23:16] * coeff_r3c9 +r3c10[23:16] * coeff_r3c10 +
r4c0[23:16] * coeff_r4c0 +r4c1[23:16] * coeff_r4c1 +r4c2[23:16] * coeff_r4c2 +r4c3[23:16] * coeff_r4c3 +r4c4[23:16] * coeff_r4c4 +r4c5[23:16] * coeff_r4c5 +r4c6[23:16] * coeff_r4c6 +r4c7[23:16] * coeff_r4c7 +r4c8[23:16] * coeff_r4c8 +r4c9[23:16] * coeff_r4c9 +r4c10[23:16] * coeff_r4c10 +
r5c0[23:16] * coeff_r5c0 +r5c1[23:16] * coeff_r5c1 +r5c2[23:16] * coeff_r5c2 +r5c3[23:16] * coeff_r5c3 +r5c4[23:16] * coeff_r5c4 +r5c5[23:16] * coeff_r5c5 +r5c6[23:16] * coeff_r5c6 +r5c7[23:16] * coeff_r5c7 +r5c8[23:16] * coeff_r5c8 +r5c9[23:16] * coeff_r5c9 +r5c10[23:16] * coeff_r5c10 +
r6c0[23:16] * coeff_r6c0 +r6c1[23:16] * coeff_r6c1 +r6c2[23:16] * coeff_r6c2 +r6c3[23:16] * coeff_r6c3 +r6c4[23:16] * coeff_r6c4 +r6c5[23:16] * coeff_r6c5 +r6c6[23:16] * coeff_r6c6 +r6c7[23:16] * coeff_r6c7 +r6c8[23:16] * coeff_r6c8 +r6c9[23:16] * coeff_r6c9 +r6c10[23:16] * coeff_r6c10 +
r7c0[23:16] * coeff_r7c0 +r7c1[23:16] * coeff_r7c1 +r7c2[23:16] * coeff_r7c2 +r7c3[23:16] * coeff_r7c3 +r7c4[23:16] * coeff_r7c4 +r7c5[23:16] * coeff_r7c5 +r7c6[23:16] * coeff_r7c6 +r7c7[23:16] * coeff_r7c7 +r7c8[23:16] * coeff_r7c8 +r7c9[23:16] * coeff_r7c9 +r7c10[23:16] * coeff_r7c10 +
r8c0[23:16] * coeff_r8c0 +r8c1[23:16] * coeff_r8c1 +r8c2[23:16] * coeff_r8c2 +r8c3[23:16] * coeff_r8c3 +r8c4[23:16] * coeff_r8c4 +r8c5[23:16] * coeff_r8c5 +r8c6[23:16] * coeff_r8c6 +r8c7[23:16] * coeff_r8c7 +r8c8[23:16] * coeff_r8c8 +r8c9[23:16] * coeff_r8c9 +r8c10[23:16] * coeff_r8c10 +
r9c0[23:16] * coeff_r9c0 +r9c1[23:16] * coeff_r9c1 +r9c2[23:16] * coeff_r9c2 +r9c3[23:16] * coeff_r9c3 +r9c4[23:16] * coeff_r9c4 +r9c5[23:16] * coeff_r9c5 +r9c6[23:16] * coeff_r9c6 +r9c7[23:16] * coeff_r9c7 +r9c8[23:16] * coeff_r9c8 +r9c9[23:16] * coeff_r9c9 +r9c10[23:16] * coeff_r9c10 +
r10c0[23:16] * coeff_r10c0 +r10c1[23:16] * coeff_r10c1 +r10c2[23:16] * coeff_r10c2 +r10c3[23:16] * coeff_r10c3 +r10c4[23:16] * coeff_r10c4 +r10c5[23:16] * coeff_r10c5 +r10c6[23:16] * coeff_r10c6 +r10c7[23:16] * coeff_r10c7 +r10c8[23:16] * coeff_r10c8 +r10c9[23:16] * coeff_r10c9 +r10c10[23:16] * coeff_r10c10;

//------------------------- GREEN ----------------------
sumG = 24'h000000 + r0c0[15:8] * coeff_r0c0 + r0c1[15:8] * coeff_r0c1 + r0c2[15:8] * coeff_r0c2 + r0c3[15:8] * coeff_r0c3 + r0c4[15:8] * coeff_r0c4 + r0c5[15:8] * coeff_r0c5 + r0c6[15:8] * coeff_r0c6 + r0c7[15:8] * coeff_r0c7 + r0c8[15:8] * coeff_r0c8 + r0c9[15:8] * coeff_r0c9 + r0c10[15:8] * coeff_r0c10 + 
r1c0[15:8] * coeff_r1c0 + r1c1[15:8] * coeff_r1c1 + r1c2[15:8] * coeff_r1c2 + r1c3[15:8] * coeff_r1c3 + r1c4[15:8] * coeff_r1c4 + r1c5[15:8] * coeff_r1c5 + r1c6[15:8] * coeff_r1c6 + r1c7[15:8] * coeff_r1c7 + r1c8[15:8] * coeff_r1c8 + r1c9[15:8] * coeff_r1c9 + r1c10[15:8] * coeff_r1c10 + 
r2c0[15:8] * coeff_r2c0 + r2c1[15:8] * coeff_r2c1 + r2c2[15:8] * coeff_r2c2 + r2c3[15:8] * coeff_r2c3 + r2c4[15:8] * coeff_r2c4 + r2c5[15:8] * coeff_r2c5 + r2c6[15:8] * coeff_r2c6 + r2c7[15:8] * coeff_r2c7 + r2c8[15:8] * coeff_r2c8 + r2c9[15:8] * coeff_r2c9 + r2c10[15:8] * coeff_r2c10 + 
r3c0[15:8] * coeff_r3c0 + r3c1[15:8] * coeff_r3c1 + r3c2[15:8] * coeff_r3c2 + r3c3[15:8] * coeff_r3c3 + r3c4[15:8] * coeff_r3c4 + r3c5[15:8] * coeff_r3c5 + r3c6[15:8] * coeff_r3c6 + r3c7[15:8] * coeff_r3c7 + r3c8[15:8] * coeff_r3c8 + r3c9[15:8] * coeff_r3c9 + r3c10[15:8] * coeff_r3c10 + 
r4c0[15:8] * coeff_r4c0 + r4c1[15:8] * coeff_r4c1 + r4c2[15:8] * coeff_r4c2 + r4c3[15:8] * coeff_r4c3 + r4c4[15:8] * coeff_r4c4 + r4c5[15:8] * coeff_r4c5 + r4c6[15:8] * coeff_r4c6 + r4c7[15:8] * coeff_r4c7 + r4c8[15:8] * coeff_r4c8 + r4c9[15:8] * coeff_r4c9 + r4c10[15:8] * coeff_r4c10 + 
r5c0[15:8] * coeff_r5c0 + r5c1[15:8] * coeff_r5c1 + r5c2[15:8] * coeff_r5c2 + r5c3[15:8] * coeff_r5c3 + r5c4[15:8] * coeff_r5c4 + r5c5[15:8] * coeff_r5c5 + r5c6[15:8] * coeff_r5c6 + r5c7[15:8] * coeff_r5c7 + r5c8[15:8] * coeff_r5c8 + r5c9[15:8] * coeff_r5c9 + r5c10[15:8] * coeff_r5c10 + 
r6c0[15:8] * coeff_r6c0 + r6c1[15:8] * coeff_r6c1 + r6c2[15:8] * coeff_r6c2 + r6c3[15:8] * coeff_r6c3 + r6c4[15:8] * coeff_r6c4 + r6c5[15:8] * coeff_r6c5 + r6c6[15:8] * coeff_r6c6 + r6c7[15:8] * coeff_r6c7 + r6c8[15:8] * coeff_r6c8 + r6c9[15:8] * coeff_r6c9 + r6c10[15:8] * coeff_r6c10 + 
r7c0[15:8] * coeff_r7c0 + r7c1[15:8] * coeff_r7c1 + r7c2[15:8] * coeff_r7c2 + r7c3[15:8] * coeff_r7c3 + r7c4[15:8] * coeff_r7c4 + r7c5[15:8] * coeff_r7c5 + r7c6[15:8] * coeff_r7c6 + r7c7[15:8] * coeff_r7c7 + r7c8[15:8] * coeff_r7c8 + r7c9[15:8] * coeff_r7c9 + r7c10[15:8] * coeff_r7c10 + 
r8c0[15:8] * coeff_r8c0 + r8c1[15:8] * coeff_r8c1 + r8c2[15:8] * coeff_r8c2 + r8c3[15:8] * coeff_r8c3 + r8c4[15:8] * coeff_r8c4 + r8c5[15:8] * coeff_r8c5 + r8c6[15:8] * coeff_r8c6 + r8c7[15:8] * coeff_r8c7 + r8c8[15:8] * coeff_r8c8 + r8c9[15:8] * coeff_r8c9 + r8c10[15:8] * coeff_r8c10 + 
r9c0[15:8] * coeff_r9c0 + r9c1[15:8] * coeff_r9c1 + r9c2[15:8] * coeff_r9c2 + r9c3[15:8] * coeff_r9c3 + r9c4[15:8] * coeff_r9c4 + r9c5[15:8] * coeff_r9c5 + r9c6[15:8] * coeff_r9c6 + r9c7[15:8] * coeff_r9c7 + r9c8[15:8] * coeff_r9c8 + r9c9[15:8] * coeff_r9c9 + r9c10[15:8] * coeff_r9c10 + 
r10c0[15:8] * coeff_r10c0 + r10c1[15:8] * coeff_r10c1 + r10c2[15:8] * coeff_r10c2 + r10c3[15:8] * coeff_r10c3 + r10c4[15:8] * coeff_r10c4 + r10c5[15:8] * coeff_r10c5 + r10c6[15:8] * coeff_r10c6 + r10c7[15:8] * coeff_r10c7 + r10c8[15:8] * coeff_r10c8 + r10c9[15:8] * coeff_r10c9 + r10c10[15:8] * coeff_r10c10; 

//------------------------ BLUE ------------------------
sumB = 24'h000000 + r0c0[7:0] * coeff_r0c0 + r0c1[7:0] * coeff_r0c1 + r0c2[7:0] * coeff_r0c2 + r0c3[7:0] * coeff_r0c3 + r0c4[7:0] * coeff_r0c4 + r0c5[7:0] * coeff_r0c5 + r0c6[7:0] * coeff_r0c6 + r0c7[7:0] * coeff_r0c7 + r0c8[7:0] * coeff_r0c8 + r0c9[7:0] * coeff_r0c9 + r0c10[7:0] * coeff_r0c10 + 
r1c0[7:0] * coeff_r1c0 + r1c1[7:0] * coeff_r1c1 + r1c2[7:0] * coeff_r1c2 + r1c3[7:0] * coeff_r1c3 + r1c4[7:0] * coeff_r1c4 + r1c5[7:0] * coeff_r1c5 + r1c6[7:0] * coeff_r1c6 + r1c7[7:0] * coeff_r1c7 + r1c8[7:0] * coeff_r1c8 + r1c9[7:0] * coeff_r1c9 + r1c10[7:0] * coeff_r1c10 + 
r2c0[7:0] * coeff_r2c0 + r2c1[7:0] * coeff_r2c1 + r2c2[7:0] * coeff_r2c2 + r2c3[7:0] * coeff_r2c3 + r2c4[7:0] * coeff_r2c4 + r2c5[7:0] * coeff_r2c5 + r2c6[7:0] * coeff_r2c6 + r2c7[7:0] * coeff_r2c7 + r2c8[7:0] * coeff_r2c8 + r2c9[7:0] * coeff_r2c9 + r2c10[7:0] * coeff_r2c10 + 
r3c0[7:0] * coeff_r3c0 + r3c1[7:0] * coeff_r3c1 + r3c2[7:0] * coeff_r3c2 + r3c3[7:0] * coeff_r3c3 + r3c4[7:0] * coeff_r3c4 + r3c5[7:0] * coeff_r3c5 + r3c6[7:0] * coeff_r3c6 + r3c7[7:0] * coeff_r3c7 + r3c8[7:0] * coeff_r3c8 + r3c9[7:0] * coeff_r3c9 + r3c10[7:0] * coeff_r3c10 + 
r4c0[7:0] * coeff_r4c0 + r4c1[7:0] * coeff_r4c1 + r4c2[7:0] * coeff_r4c2 + r4c3[7:0] * coeff_r4c3 + r4c4[7:0] * coeff_r4c4 + r4c5[7:0] * coeff_r4c5 + r4c6[7:0] * coeff_r4c6 + r4c7[7:0] * coeff_r4c7 + r4c8[7:0] * coeff_r4c8 + r4c9[7:0] * coeff_r4c9 + r4c10[7:0] * coeff_r4c10 + 
r5c0[7:0] * coeff_r5c0 + r5c1[7:0] * coeff_r5c1 + r5c2[7:0] * coeff_r5c2 + r5c3[7:0] * coeff_r5c3 + r5c4[7:0] * coeff_r5c4 + r5c5[7:0] * coeff_r5c5 + r5c6[7:0] * coeff_r5c6 + r5c7[7:0] * coeff_r5c7 + r5c8[7:0] * coeff_r5c8 + r5c9[7:0] * coeff_r5c9 + r5c10[7:0] * coeff_r5c10 + 
r6c0[7:0] * coeff_r6c0 + r6c1[7:0] * coeff_r6c1 + r6c2[7:0] * coeff_r6c2 + r6c3[7:0] * coeff_r6c3 + r6c4[7:0] * coeff_r6c4 + r6c5[7:0] * coeff_r6c5 + r6c6[7:0] * coeff_r6c6 + r6c7[7:0] * coeff_r6c7 + r6c8[7:0] * coeff_r6c8 + r6c9[7:0] * coeff_r6c9 + r6c10[7:0] * coeff_r6c10 + 
r7c0[7:0] * coeff_r7c0 + r7c1[7:0] * coeff_r7c1 + r7c2[7:0] * coeff_r7c2 + r7c3[7:0] * coeff_r7c3 + r7c4[7:0] * coeff_r7c4 + r7c5[7:0] * coeff_r7c5 + r7c6[7:0] * coeff_r7c6 + r7c7[7:0] * coeff_r7c7 + r7c8[7:0] * coeff_r7c8 + r7c9[7:0] * coeff_r7c9 + r7c10[7:0] * coeff_r7c10 + 
r8c0[7:0] * coeff_r8c0 + r8c1[7:0] * coeff_r8c1 + r8c2[7:0] * coeff_r8c2 + r8c3[7:0] * coeff_r8c3 + r8c4[7:0] * coeff_r8c4 + r8c5[7:0] * coeff_r8c5 + r8c6[7:0] * coeff_r8c6 + r8c7[7:0] * coeff_r8c7 + r8c8[7:0] * coeff_r8c8 + r8c9[7:0] * coeff_r8c9 + r8c10[7:0] * coeff_r8c10 + 
r9c0[7:0] * coeff_r9c0 + r9c1[7:0] * coeff_r9c1 + r9c2[7:0] * coeff_r9c2 + r9c3[7:0] * coeff_r9c3 + r9c4[7:0] * coeff_r9c4 + r9c5[7:0] * coeff_r9c5 + r9c6[7:0] * coeff_r9c6 + r9c7[7:0] * coeff_r9c7 + r9c8[7:0] * coeff_r9c8 + r9c9[7:0] * coeff_r9c9 + r9c10[7:0] * coeff_r9c10 + 
r10c0[7:0] * coeff_r10c0 + r10c1[7:0] * coeff_r10c1 + r10c2[7:0] * coeff_r10c2 + r10c3[7:0] * coeff_r10c3 + r10c4[7:0] * coeff_r10c4 + r10c5[7:0] * coeff_r10c5 + r10c6[7:0] * coeff_r10c6 + r10c7[7:0] * coeff_r10c7 + r10c8[7:0] * coeff_r10c8 + r10c9[7:0] * coeff_r10c9 + r10c10[7:0] * coeff_r10c10;

end

always @(*) begin
case(filt_sel)
2'b00: begin // default
coeff_r0c0 = 8'h00;coeff_r0c1 = 8'h00;coeff_r0c2 = 8'h00;coeff_r0c3 = 8'h00;coeff_r0c4 = 8'h00;coeff_r0c5 = 8'h00;coeff_r0c6 = 8'h00;coeff_r0c7 = 8'h00;coeff_r0c8 = 8'h00;coeff_r0c9 = 8'h00;coeff_r0c10 = 8'h00;
coeff_r1c0 = 8'h00;coeff_r1c1 = 8'h00;coeff_r1c2 = 8'h00;coeff_r1c3 = 8'h00;coeff_r1c4 = 8'h00;coeff_r1c5 = 8'h00;coeff_r1c6 = 8'h00;coeff_r1c7 = 8'h00;coeff_r1c8 = 8'h00;coeff_r1c9 = 8'h00;coeff_r1c10 = 8'h00;
coeff_r2c0 = 8'h00;coeff_r2c1 = 8'h00;coeff_r2c2 = 8'h00;coeff_r2c3 = 8'h00;coeff_r2c4 = 8'h00;coeff_r2c5 = 8'h00;coeff_r2c6 = 8'h00;coeff_r2c7 = 8'h00;coeff_r2c8 = 8'h00;coeff_r2c9 = 8'h00;coeff_r2c10 = 8'h00;
coeff_r3c0 = 8'h00;coeff_r3c1 = 8'h00;coeff_r3c2 = 8'h00;coeff_r3c3 = 8'h00;coeff_r3c4 = 8'h00;coeff_r3c5 = 8'h00;coeff_r3c6 = 8'h00;coeff_r3c7 = 8'h00;coeff_r3c8 = 8'h00;coeff_r3c9 = 8'h00;coeff_r3c10 = 8'h00;
coeff_r4c0 = 8'h00;coeff_r4c1 = 8'h00;coeff_r4c2 = 8'h00;coeff_r4c3 = 8'h00;coeff_r4c4 = 8'h00;coeff_r4c5 = 8'h00;coeff_r4c6 = 8'h00;coeff_r4c7 = 8'h00;coeff_r4c8 = 8'h00;coeff_r4c9 = 8'h00;coeff_r4c10 = 8'h00;
coeff_r5c0 = 8'h00;coeff_r5c1 = 8'h00;coeff_r5c2 = 8'h00;coeff_r5c3 = 8'h00;coeff_r5c4 = 8'h00;coeff_r5c5 = 8'hFF;coeff_r5c6 = 8'h00;coeff_r5c7 = 8'h00;coeff_r5c8 = 8'h00;coeff_r5c9 = 8'h00;coeff_r5c10 = 8'h00;
coeff_r6c0 = 8'h00;coeff_r6c1 = 8'h00;coeff_r6c2 = 8'h00;coeff_r6c3 = 8'h00;coeff_r6c4 = 8'h00;coeff_r6c5 = 8'h00;coeff_r6c6 = 8'h00;coeff_r6c7 = 8'h00;coeff_r6c8 = 8'h00;coeff_r6c9 = 8'h00;coeff_r6c10 = 8'h00;
coeff_r7c0 = 8'h00;coeff_r7c1 = 8'h00;coeff_r7c2 = 8'h00;coeff_r7c3 = 8'h00;coeff_r7c4 = 8'h00;coeff_r7c5 = 8'h00;coeff_r7c6 = 8'h00;coeff_r7c7 = 8'h00;coeff_r7c8 = 8'h00;coeff_r7c9 = 8'h00;coeff_r7c10 = 8'h00;
coeff_r8c0 = 8'h00;coeff_r8c1 = 8'h00;coeff_r8c2 = 8'h00;coeff_r8c3 = 8'h00;coeff_r8c4 = 8'h00;coeff_r8c5 = 8'h00;coeff_r8c6 = 8'h00;coeff_r8c7 = 8'h00;coeff_r8c8 = 8'h00;coeff_r8c9 = 8'h00;coeff_r8c10 = 8'h00;
coeff_r9c0 = 8'h00;coeff_r9c1 = 8'h00;coeff_r9c2 = 8'h00;coeff_r9c3 = 8'h00;coeff_r9c4 = 8'h00;coeff_r9c5 = 8'h00;coeff_r9c6 = 8'h00;coeff_r9c7 = 8'h00;coeff_r9c8 = 8'h00;coeff_r9c9 = 8'h00;coeff_r9c10 = 8'h00;
coeff_r10c0 = 8'h00;coeff_r10c1 = 8'h00;coeff_r10c2 = 8'h00;coeff_r10c3 = 8'h00;coeff_r10c4 = 8'h00;coeff_r10c5 = 8'h00;coeff_r10c6 = 8'h00;coeff_r10c7 = 8'h00;coeff_r10c8 = 8'h00;coeff_r10c9 = 8'h00;coeff_r10c10 = 8'h00;
end
2'b01: begin // 5x5
coeff_r0c0 = 8'h00;coeff_r0c1 = 8'h00;coeff_r0c2 = 8'h00;coeff_r0c3 = 8'h00;coeff_r0c4 = 8'h00;coeff_r0c5 = 8'h00;coeff_r0c6 = 8'h00;coeff_r0c7 = 8'h00;coeff_r0c8 = 8'h00;coeff_r0c9 = 8'h00;coeff_r0c10 = 8'h00;
coeff_r1c0 = 8'h00;coeff_r1c1 = 8'h00;coeff_r1c2 = 8'h00;coeff_r1c3 = 8'h00;coeff_r1c4 = 8'h00;coeff_r1c5 = 8'h00;coeff_r1c6 = 8'h00;coeff_r1c7 = 8'h00;coeff_r1c8 = 8'h00;coeff_r1c9 = 8'h00;coeff_r1c10 = 8'h00;
coeff_r2c0 = 8'h00;coeff_r2c1 = 8'h00;coeff_r2c2 = 8'h00;coeff_r2c3 = 8'h00;coeff_r2c4 = 8'h00;coeff_r2c5 = 8'h00;coeff_r2c6 = 8'h00;coeff_r2c7 = 8'h00;coeff_r2c8 = 8'h00;coeff_r2c9 = 8'h00;coeff_r2c10 = 8'h00;
coeff_r3c0 = 8'h00;coeff_r3c1 = 8'h00;coeff_r3c2 = 8'h00;coeff_r3c3 = 8'b00001001;coeff_r3c4 = 8'b00001010;coeff_r3c5 = 8'b00001010;coeff_r3c6 = 8'b00001010;coeff_r3c7 = 8'b00001001;coeff_r3c8 = 8'h00;coeff_r3c9 = 8'h00;coeff_r3c10 = 8'h00;
coeff_r4c0 = 8'h00;coeff_r4c1 = 8'h00;coeff_r4c2 = 8'h00;coeff_r4c3 = 8'b00001010;coeff_r4c4 = 8'b00001011;coeff_r4c5 = 8'b00001011;coeff_r4c6 = 8'b00001011;coeff_r4c7 = 8'b00001010;coeff_r4c8 = 8'h00;coeff_r4c9 = 8'h00;coeff_r4c10 = 8'h00;
coeff_r5c0 = 8'h00;coeff_r5c1 = 8'h00;coeff_r5c2 = 8'h00;coeff_r5c3 = 8'b00001010;coeff_r5c4 = 8'b00001011;coeff_r5c5 = 8'b00001011;coeff_r5c6 = 8'b00001011;coeff_r5c7 = 8'b00001010;coeff_r5c8 = 8'h00;coeff_r5c9 = 8'h00;coeff_r5c10 = 8'h00;
coeff_r6c0 = 8'h00;coeff_r6c1 = 8'h00;coeff_r6c2 = 8'h00;coeff_r6c3 = 8'b00001010;coeff_r6c4 = 8'b00001011;coeff_r6c5 = 8'b00001011;coeff_r6c6 = 8'b00001001;coeff_r6c7 = 8'b00001010;coeff_r6c8 = 8'h00;coeff_r6c9 = 8'h00;coeff_r6c10 = 8'h00;
coeff_r7c0 = 8'h00;coeff_r7c1 = 8'h00;coeff_r7c2 = 8'h00;coeff_r7c3 = 8'b00001001;coeff_r7c4 = 8'b00001010;coeff_r7c5 = 8'b00001010;coeff_r7c6 = 8'b00001010;coeff_r7c7 = 8'b00001011;coeff_r7c8 = 8'h00;coeff_r7c9 = 8'h00;coeff_r7c10 = 8'h00;
coeff_r8c0 = 8'h00;coeff_r8c1 = 8'h00;coeff_r8c2 = 8'h00;coeff_r8c3 = 8'h00;coeff_r8c4 = 8'h00;coeff_r8c5 = 8'h00;coeff_r8c6 = 8'h00;coeff_r8c7 = 8'h00;coeff_r8c8 = 8'h00;coeff_r8c9 = 8'h00;coeff_r8c10 = 8'h00;
coeff_r9c0 = 8'h00;coeff_r9c1 = 8'h00;coeff_r9c2 = 8'h00;coeff_r9c3 = 8'h00;coeff_r9c4 = 8'h00;coeff_r9c5 = 8'h00;coeff_r9c6 = 8'h00;coeff_r9c7 = 8'h00;coeff_r9c8 = 8'h00;coeff_r9c9 = 8'h00;coeff_r9c10 = 8'h00;
coeff_r10c0 = 8'h00;coeff_r10c1 = 8'h00;coeff_r10c2 = 8'h00;coeff_r10c3 = 8'h00;coeff_r10c4 = 8'h00;coeff_r10c5 = 8'h00;coeff_r10c6 = 8'h00;coeff_r10c7 = 8'h00;coeff_r10c8 = 8'h00;coeff_r10c9 = 8'h00;coeff_r10c10 = 8'h00;
end
2'b10: begin // 7x7
coeff_r0c0 = 8'h00;coeff_r0c1 = 8'h00;coeff_r0c2 = 8'h00;coeff_r0c3 = 8'h00;coeff_r0c4 = 8'h00;coeff_r0c5 = 8'h00;coeff_r0c6 = 8'h00;coeff_r0c7 = 8'h00;coeff_r0c8 = 8'h00;coeff_r0c9 = 8'h00;coeff_r0c10 = 8'h00;
coeff_r1c0 = 8'h00;coeff_r1c1 = 8'h00;coeff_r1c2 = 8'h00;coeff_r1c3 = 8'h00;coeff_r1c4 = 8'h00;coeff_r1c5 = 8'h00;coeff_r1c6 = 8'h00;coeff_r1c7 = 8'h00;coeff_r1c8 = 8'h00;coeff_r1c9 = 8'h00;coeff_r1c10 = 8'h00;
coeff_r2c0 = 8'h00;coeff_r2c1 = 8'h00;coeff_r2c2 = 8'b00000011;coeff_r2c3 = 8'b00000100;coeff_r2c4 = 8'b00000101;coeff_r2c5 =  8'b00000101;coeff_r2c6 = 8'b00000101;coeff_r2c7 = 8'b00000100;coeff_r2c8 = 8'b00000011;coeff_r2c9 = 8'h00;coeff_r2c10 = 8'h00;
coeff_r3c0 = 8'h00;coeff_r3c1 = 8'h00;coeff_r3c2 = 8'b00000100;coeff_r3c3 = 8'b00000101;coeff_r3c4 = 8'b00000110;coeff_r3c5 = 8'b00000110;coeff_r3c6 = 8'b00000110;coeff_r3c7 = 8'b00000101;coeff_r3c8 = 8'b00000100;coeff_r3c9 = 8'h00;coeff_r3c10 = 8'h00;
coeff_r4c0 = 8'h00;coeff_r4c1 = 8'h00;coeff_r4c2 = 8'b00000101;coeff_r4c3 = 8'b00000110;coeff_r4c4 = 8'b00000111;coeff_r4c5 = 8'b00000111;coeff_r4c6 = 8'b00000111;coeff_r4c7 = 8'b00000110;coeff_r4c8 = 8'b00000101;coeff_r4c9 = 8'h00;coeff_r4c10 = 8'h00;
coeff_r5c0 = 8'h00;coeff_r5c1 = 8'h00;coeff_r5c2 = 8'b00000101;coeff_r5c3 = 8'b00000110; coeff_r5c4 = 8'b00000111;coeff_r5c5 = 8'b00001000;coeff_r5c6 = 8'b00000111;coeff_r5c7 = 8'b00000110;coeff_r5c8 = 8'b00000101;coeff_r5c9 = 8'h00;coeff_r5c10 = 8'h00;
coeff_r6c0 = 8'h00;coeff_r6c1 = 8'h00;coeff_r6c2 = 8'b00000101;coeff_r6c3 = 8'b00000110;coeff_r6c4 = 8'b00000111;coeff_r6c5 = 8'b00000111;coeff_r6c6 = 8'b00000111;coeff_r6c7 = 8'b00000110;coeff_r6c8 = 8'b00000101;coeff_r6c9 = 8'h00;coeff_r6c10 = 8'h00;
coeff_r7c0 = 8'h00;coeff_r7c1 = 8'h00;coeff_r7c2 = 8'b00000100;coeff_r7c3 = 8'b00000101;coeff_r7c4 = 8'b00000110;coeff_r7c5 = 8'b00000110;coeff_r7c6 = 8'b00000110;coeff_r7c7 = 8'b00000101;coeff_r7c8 = 8'b00000100;coeff_r7c9 = 8'h00;coeff_r7c10 = 8'h00;
coeff_r8c0 = 8'h00;coeff_r8c1 = 8'h00;coeff_r8c2 = 8'b00000011;coeff_r8c3 = 8'b00000100;coeff_r8c4 = 8'b00000101;coeff_r8c5 = 8'b00000101;coeff_r8c6 = 8'b00000101;coeff_r8c7 = 8'b00000100;coeff_r8c8 = 8'b00000011;coeff_r8c9 = 8'h00;coeff_r8c10 = 8'h00;
coeff_r9c0 = 8'h00;coeff_r9c1 = 8'h00;coeff_r9c2 = 8'h00;coeff_r9c3 = 8'h00;coeff_r9c4 = 8'h00;coeff_r9c5 = 8'h00;coeff_r9c6 = 8'h00;coeff_r9c7 = 8'h00;coeff_r9c8 = 8'h00;coeff_r9c9 = 8'h00;coeff_r9c10 = 8'h00;
coeff_r10c0 = 8'h00;coeff_r10c1 = 8'h00;coeff_r10c2 = 8'h00;coeff_r10c3 = 8'h00;coeff_r10c4 = 8'h00;coeff_r10c5 = 8'h00;coeff_r10c6 = 8'h00;coeff_r10c7 = 8'h00;coeff_r10c8 = 8'h00;coeff_r10c9 = 8'h00;coeff_r10c10 = 8'h00;
end

2'b11: begin //11x11

coeff_r0c0 = mem[0][0];
coeff_r0c1 = mem[0][1];
coeff_r0c2 = mem[0][2];
coeff_r0c3 = mem[0][3];
coeff_r0c4 = mem[0][4];
coeff_r0c5 = mem[0][5];
coeff_r0c6 = mem[0][6];
coeff_r0c7 = mem[0][7];
coeff_r0c8 = mem[0][8];
coeff_r0c9 = mem[0][9];
coeff_r0c10 = mem[0][10];
coeff_r1c0 = mem[1][0];
coeff_r1c1 = mem[1][1];
coeff_r1c2 = mem[1][2];
coeff_r1c3 = mem[1][3];
coeff_r1c4 = mem[1][4];
coeff_r1c5 = mem[1][5];
coeff_r1c6 = mem[1][6];
coeff_r1c7 = mem[1][7];
coeff_r1c8 = mem[1][8];
coeff_r1c9 = mem[1][9];
coeff_r1c10 = mem[1][10];
coeff_r2c0 = mem[2][0];
coeff_r2c1 = mem[2][1];
coeff_r2c2 = mem[2][2];
coeff_r2c3 = mem[2][3];
coeff_r2c4 = mem[2][4];
coeff_r2c5 = mem[2][5];
coeff_r2c6 = mem[2][6];
coeff_r2c7 = mem[2][7];
coeff_r2c8 = mem[2][8];
coeff_r2c9 = mem[2][9];
coeff_r2c10 = mem[2][10];
coeff_r3c0 = mem[3][0];
coeff_r3c1 = mem[3][1];
coeff_r3c2 = mem[3][2];
coeff_r3c3 = mem[3][3];
coeff_r3c4 = mem[3][4];
coeff_r3c5 = mem[3][5];
coeff_r3c6 = mem[3][6];
coeff_r3c7 = mem[3][7];
coeff_r3c8 = mem[3][8];
coeff_r3c9 = mem[3][9];
coeff_r3c10 = mem[3][10];
coeff_r4c0 = mem[4][0];
coeff_r4c1 = mem[4][1];
coeff_r4c2 = mem[4][2];
coeff_r4c3 = mem[4][3];
coeff_r4c4 = mem[4][4];
coeff_r4c5 = mem[4][5];
coeff_r4c6 = mem[4][6];
coeff_r4c7 = mem[4][7];
coeff_r4c8 = mem[4][8];
coeff_r4c9 = mem[4][9];
coeff_r4c10 = mem[4][10];
coeff_r5c0 = mem[5][0];
coeff_r5c1 = mem[5][1];
coeff_r5c2 = mem[5][2];
coeff_r5c3 = mem[5][3];
coeff_r5c4 = mem[5][4];
coeff_r5c5 = mem[5][5];
coeff_r5c6 = mem[5][6];
coeff_r5c7 = mem[5][7];
coeff_r5c8 = mem[5][8];
coeff_r5c9 = mem[5][9];
coeff_r5c10 = mem[5][10];
coeff_r6c0 = mem[6][0];
coeff_r6c1 = mem[6][1];
coeff_r6c2 = mem[6][2];
coeff_r6c3 = mem[6][3];
coeff_r6c4 = mem[6][4];
coeff_r6c5 = mem[6][5];
coeff_r6c6 = mem[6][6];
coeff_r6c7 = mem[6][7];
coeff_r6c8 = mem[6][8];
coeff_r6c9 = mem[6][9];
coeff_r6c10 = mem[6][10];
coeff_r7c0 = mem[7][0];
coeff_r7c1 = mem[7][1];
coeff_r7c2 = mem[7][2];
coeff_r7c3 = mem[7][3];
coeff_r7c4 = mem[7][4];
coeff_r7c5 = mem[7][5];
coeff_r7c6 = mem[7][6];
coeff_r7c7 = mem[7][7];
coeff_r7c8 = mem[7][8];
coeff_r7c9 = mem[7][9];
coeff_r7c10 = mem[7][10];
coeff_r8c0 = mem[8][0];
coeff_r8c1 = mem[8][1];
coeff_r8c2 = mem[8][2];
coeff_r8c3 = mem[8][3];
coeff_r8c4 = mem[8][4];
coeff_r8c5 = mem[8][5];
coeff_r8c6 = mem[8][6];
coeff_r8c7 = mem[8][7];
coeff_r8c8 = mem[8][8];
coeff_r8c9 = mem[8][9];
coeff_r8c10 = mem[8][10];
coeff_r9c0 = mem[9][0];
coeff_r9c1 = mem[9][1];
coeff_r9c2 = mem[9][2];
coeff_r9c3 = mem[9][3];
coeff_r9c4 = mem[9][4];
coeff_r9c5 = mem[9][5];
coeff_r9c6 = mem[9][6];
coeff_r9c7 = mem[9][7];
coeff_r9c8 = mem[9][8];
coeff_r9c9 = mem[9][9];
coeff_r9c10 = mem[9][10];
coeff_r10c0 = mem[10][0];
coeff_r10c1 = mem[10][1];
coeff_r10c2 = mem[10][2];
coeff_r10c3 = mem[10][3];
coeff_r10c4 = mem[10][4];
coeff_r10c5 = mem[10][5];
coeff_r10c6 = mem[10][6];
coeff_r10c7 = mem[10][7];
coeff_r10c8 = mem[10][8];
coeff_r10c9 = mem[10][9];
coeff_r10c10 = mem[10][10];
end
endcase
end

initial begin
	mem[0][0] = 8'b00000001;
	mem[0][1] = 8'b00000001;
	mem[0][2] = 8'b00000010;
	mem[0][3] = 8'b00000010;
	mem[0][4] = 8'b00000010;
	mem[0][5] = 8'b00000010;
	mem[0][6] = 8'b00000010;
	mem[0][7] = 8'b00000010;
	mem[0][8] = 8'b00000010;
	mem[0][9] = 8'b00000001;
	mem[0][10] = 8'b00000001;
	mem[1][0] = 8'b00000001;
	mem[1][1] = 8'b00000010;
	mem[1][2] = 8'b00000010;
	mem[1][3] = 8'b00000010;
	mem[1][4] = 8'b00000010;
	mem[1][5] = 8'b00000010;
	mem[1][6] = 8'b00000010;
	mem[1][7] = 8'b00000010;
	mem[1][8] = 8'b00000010;
	mem[1][9] = 8'b00000010;
	mem[1][10] = 8'b00000001;
	mem[2][0] = 8'b00000010;
	mem[2][1] = 8'b00000010;
	mem[2][2] = 8'b00000010;
	mem[2][3] = 8'b00000010;
	mem[2][4] = 8'b00000011;
	mem[2][5] = 8'b00000011;
	mem[2][6] = 8'b00000011;
	mem[2][7] = 8'b00000010;
	mem[2][8] = 8'b00000010;
	mem[2][9] = 8'b00000010;
	mem[2][10] = 8'b00000010;
	mem[3][0] = 8'b00000010;
	mem[3][1] = 8'b00000010;
	mem[3][2] = 8'b00000010;
	mem[3][3] = 8'b00000011;
	mem[3][4] = 8'b00000011;
	mem[3][5] = 8'b00000011;
	mem[3][6] = 8'b00000011;
	mem[3][7] = 8'b00000011;
	mem[3][8] = 8'b00000010;
	mem[3][9] = 8'b00000010;
	mem[3][10] = 8'b00000010;
	mem[4][0] = 8'b00000010;
	mem[4][1] = 8'b00000010;
	mem[4][2] = 8'b00000011;
	mem[4][3] = 8'b00000011;
	mem[4][4] = 8'b00000011;
	mem[4][5] = 8'b00000011;
	mem[4][6] = 8'b00000011;
	mem[4][7] = 8'b00000011;
	mem[4][8] = 8'b00000011;
	mem[4][9] = 8'b00000010;
	mem[4][10] = 8'b00000010;
	mem[5][0] = 8'b00000010;
	mem[5][1] = 8'b00000010;
	mem[5][2] = 8'b00000011;
	mem[5][3] = 8'b00000011;
	mem[5][4] = 8'b00000011;
	mem[5][5] = 8'b00000011;
	mem[5][6] = 8'b00000011;
	mem[5][7] = 8'b00000011;
	mem[5][8] = 8'b00000011;
	mem[5][9] = 8'b00000010;
	mem[5][10] = 8'b00000010;
	mem[6][0] = 8'b00000010;
	mem[6][1] = 8'b00000010;
	mem[6][2] = 8'b00000011;
	mem[6][3] = 8'b00000011;
	mem[6][4] = 8'b00000011;
	mem[6][5] = 8'b00000011;
	mem[6][6] = 8'b00000011;
	mem[6][7] = 8'b00000011;
	mem[6][8] = 8'b00000011;
	mem[6][9] = 8'b00000010;
	mem[6][10] = 8'b00000010;
	mem[7][0] = 8'b00000010;
	mem[7][1] = 8'b00000010;
	mem[7][2] = 8'b00000010;
	mem[7][3] = 8'b00000011;
	mem[7][4] = 8'b00000011;
	mem[7][5] = 8'b00000011;
	mem[7][6] = 8'b00000011;
	mem[7][7] = 8'b00000011;
	mem[7][8] = 8'b00000010;
	mem[7][9] = 8'b00000010;
	mem[7][10] = 8'b00000010;
	mem[8][0] = 8'b00000010;
	mem[8][1] = 8'b00000010;
	mem[8][2] = 8'b00000010;
	mem[8][3] = 8'b00000010;
	mem[8][4] = 8'b00000011;
	mem[8][5] = 8'b00000011;
	mem[8][6] = 8'b00000011;
	mem[8][7] = 8'b00000010;
	mem[8][8] = 8'b00000010;
	mem[8][9] = 8'b00000010;
	mem[8][10] = 8'b00000010;
	mem[9][0] = 8'b00000001;
	mem[9][1] = 8'b00000010;
	mem[9][2] = 8'b00000010;
	mem[9][3] = 8'b00000010;
	mem[9][4] = 8'b00000010;
	mem[9][5] = 8'b00000010;
	mem[9][6] = 8'b00000010;
	mem[9][7] = 8'b00000010;
	mem[9][8] = 8'b00000010;
	mem[9][9] = 8'b00000010;
	mem[9][10] = 8'b00000001;
	mem[10][0] = 8'b00000001;
	mem[10][1] = 8'b00000001;
	mem[10][2] = 8'b00000010;
	mem[10][3] = 8'b00000010;
	mem[10][4] = 8'b00000010;
	mem[10][5] = 8'b00000010;
	mem[10][6] = 8'b00000010;
	mem[10][7] = 8'b00000010;
	mem[10][8] = 8'b00000010;
	mem[10][9] = 8'b00000001;
	mem[10][10] = 8'b00000001;
end

endmodule