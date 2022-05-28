module edge_det_pass_thru (
  input clk,
  input [12:0] col,
  input [12:0] x_count,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

wire row_shift_en0, row_shift_en1;
row_shift_en_gen en_gen0 (col, x_count, row_shift_en0, row_shift_en1, , , , , , , , , ); 

wire [9:0] adr0, adr1, adr2;
shift_adr shiftadrs0 (col[9:0], 10'd0639, adr0, adr1, adr2, , , , , , , , );

wire [23:0] r0c0, r0c1, r0c2, 
				r1c0, r1c1;
				
assign pass_thru = r1c1;

wire [23:0] row0_out, row1_out;
wire [23:0] shift_reg_in0, shift_reg_in1;
assign shift_reg_in0 = pass_in;

wire shift_en = row_shift_en0;

rowRam r0 (.clk(clk), .wr_en(row_shift_en0), .addr(adr0), .rd_adr(adr1), .rd_adr2(adr1), .data_in(pass_in), .data_out(row0_out), .data_out2());
rowRam r1 (.clk(clk), .wr_en(row_shift_en1), .addr(adr1), .rd_adr(adr2), .rd_adr2(adr0), .data_in(row0_out), .data_out(row1_out), .data_out2(shift_reg_in1));


shift_reg c0 (.pixel(shift_reg_in0), .clk(clk), .shift_en(shift_en), .reg_0(r0c0), .reg_1(r0c1), .reg_2(r0c2));
shift_reg c1 (.pixel(shift_reg_in1), .clk(clk), .shift_en(shift_en), .reg_0(r1c0), .reg_1(r1c1));

endmodule
