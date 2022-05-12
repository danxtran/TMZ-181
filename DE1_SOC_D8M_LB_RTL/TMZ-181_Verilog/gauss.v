module gauss(
input clk,
input [7:0] r, b , g,
input [12:0] col,
input [12:0] x_count,
input en,
input filt_sel,
output [7:0] out_r, out_g, out_b

);


wire [23:0] pixel_in = {r, g, b};

wire row_shift_en0, row_shift_en1, row_shift_en2, row_shift_en3, row_shift_en4, row_shift_en5, row_shift_en6, row_shift_en7, row_shift_en8, row_shift_en9, row_shift_en10;
row_shift_en_gen en_gen0 (col, x_count, row_shift_en0, row_shift_en1, row_shift_en2, row_shift_en3, row_shift_en4, row_shift_en5, row_shift_en6, row_shift_en7, row_shift_en8, row_shift_en9, row_shift_en10); 

wire [9:0] adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8, adr9, adr10;
shift_adr shiftadrs0 (col[9:0], 10'd0639, adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8, adr9, adr10);


//
//saturate satr(.in(r10_out[0][17:8]), .out(out_r));
//saturate satb(.in(tmp_1[1][17:8]), .out(out_g));
//saturate satg(.in(tmp_1[2][17:8]), .out(out_b));
wire [23:0] row0_out, row1_out, row2_out, row3_out, row4_out, row5_out, row6_out, row7_out, row8_out, row9_out, row10_out;

assign out_r = row10_out[23:16];
assign out_g = row10_out[15:8];
assign out_b = row10_out[7:0];

rowRam r0 (.clk(clk), .wr_en(row_shift_en0), .addr(adr0), .rd_adr(adr1), .data_in(pixel_in), .data_out(row0_out));
rowRam r1 (.clk(clk), .wr_en(row_shift_en1), .addr(adr1), .rd_adr(adr2), .data_in(row0_out), .data_out(row1_out));
rowRam r2 (.clk(clk), .wr_en(row_shift_en2), .addr(adr2), .rd_adr(adr3), .data_in(row1_out), .data_out(row2_out));
rowRam r3 (.clk(clk), .wr_en(row_shift_en3), .addr(adr3), .rd_adr(adr4), .data_in(row2_out), .data_out(row3_out));
rowRam r4 (.clk(clk), .wr_en(row_shift_en4), .addr(adr4), .rd_adr(adr5), .data_in(row3_out), .data_out(row4_out));
rowRam r5 (.clk(clk), .wr_en(row_shift_en5), .addr(adr5), .rd_adr(adr6), .data_in(row4_out), .data_out(row5_out));
rowRam r6 (.clk(clk), .wr_en(row_shift_en6), .addr(adr6), .rd_adr(adr7), .data_in(row5_out), .data_out(row6_out));
rowRam r7 (.clk(clk), .wr_en(row_shift_en7), .addr(adr7), .rd_adr(adr8), .data_in(row6_out), .data_out(row7_out));
rowRam r8 (.clk(clk), .wr_en(row_shift_en8), .addr(adr8), .rd_adr(adr9), .data_in(row7_out), .data_out(row8_out));
rowRam r9 (.clk(clk), .wr_en(row_shift_en9), .addr(adr9), .rd_adr(adr10), .data_in(row8_out), .data_out(row9_out));
rowRam r10 (.clk(clk), .wr_en(row_shift_en10), .addr(adr10), .rd_adr(col), .data_in(row9_out), .data_out(row10_out));


always @(*) begin


end
always @(posedge clk) begin

end

endmodule





module row_shift_en_gen (
	input [12:0] col,
	input [12:0] x_count,
	output reg en0,
	output reg en1,
	output reg en2,
	output reg en3,
	output reg en4,
	output reg en5,
	output reg en6,
	output reg en7,
	output reg en8,
	output reg en9,
	output reg en10
);

always @(*) begin
	en0 = 1'b0;
	en1 = 1'b0;
	en2 = 1'b0;
	en3 = 1'b0;
	en4 = 1'b0;
	en5 = 1'b0;
	en6 = 1'b0;
	en7 = 1'b0;
	en8 = 1'b0;
	en9 = 1'b0;
	en10 = 1'b0;

	/* C code for if needs range change
	for (int i = 0; i <= 10; i++)
    printf("\tif (col < 13'd0%i || x_count > 13'd0%i) begin\n\t\ten%i = 1'b1;\n\tend\n", 640-i, 799-i, i);
	 */	
	
	if (col < 13'd0640 || x_count > 13'd0164) begin
		en0 = 1'b1;
	end
	if (col < 13'd0639 || x_count > 13'd0163) begin
		en1 = 1'b1;
	end
	if (col < 13'd0638 || x_count > 13'd0162) begin
		en2 = 1'b1;
	end
	if (col < 13'd0637 || x_count > 13'd0161) begin
		en3 = 1'b1;
	end
	if (col < 13'd0636 || x_count > 13'd0160) begin
		en4 = 1'b1;
	end
	if (col < 13'd0635 || x_count > 13'd0159) begin
		en5 = 1'b1;
	end
	if (col < 13'd0634 || x_count > 13'd0158) begin
		en6 = 1'b1;
	end
	if (col < 13'd0633 || x_count > 13'd0157) begin
		en7 = 1'b1;
	end
	if (col < 13'd0632 || x_count > 13'd0156) begin
		en8 = 1'b1;
	end
	if (col < 13'd0631 || x_count > 13'd0155) begin
		en9 = 1'b1;
	end
	if (col < 13'd0630 || x_count > 13'd0154) begin
		en10 = 1'b1;
	end

	
end

endmodule 


module shift_adr (
	input [9:0] ref,
	input [9:0] max,
	output [9:0] adr0,
	output [9:0] adr1,
	output [9:0] adr2,
	output [9:0] adr3,
	output [9:0] adr4,
	output [9:0] adr5,
	output [9:0] adr6,
	output [9:0] adr7,
	output [9:0] adr8,
	output [9:0] adr9,
	output [9:0] adr10
);

wire [9:0] adr1_c, adr2_c, adr3_c, adr4_c, adr5_c, adr6_c, adr7_c, adr8_c, adr9_c, adr10_c; 

assign adr0 = ref;
assign adr1 = adr1_c;
assign adr2 = adr2_c;
assign adr3 = adr3_c;
assign adr4 = adr4_c;
assign adr5 = adr5_c;
assign adr6 = adr6_c;
assign adr7 = adr7_c;
assign adr8 = adr8_c;
assign adr9 = adr9_c;
assign adr10 = adr10_c;

sat_adr as1 (ref + 10'd1, max, adr1_c);
sat_adr as2 (ref + 10'd2, max, adr2_c);
sat_adr as3 (ref + 10'd3, max, adr3_c);
sat_adr as4 (ref + 10'd4, max, adr4_c);
sat_adr as5 (ref + 10'd5, max, adr5_c);
sat_adr as6 (ref + 10'd6, max, adr6_c);
sat_adr as7 (ref + 10'd7, max, adr7_c);
sat_adr as8 (ref + 10'd8, max, adr8_c);
sat_adr as9 (ref + 10'd9, max, adr9_c);
sat_adr as10 (ref + 10'd10, max, adr10_c);

endmodule

module sat_adr (
	input [9:0] in,
	input [9:0] max,
	output reg [9:0] out
);

always @(*) begin
	out = in;
	if (in > max) begin
		out = 10'h000;
	end
end

endmodule


