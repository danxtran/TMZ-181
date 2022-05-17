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

wire [9:0] adr0_c, adr1_c, adr2_c, adr3_c, adr4_c, adr5_c, adr6_c, adr7_c, adr8_c, adr9_c, adr10_c; 

assign adr0 = adr0_c;
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

sat_adr as0 (ref , max, adr0_c);
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
