module sobel_edge_det(
//p0 - p8 :8 pixel sourding by the target pixel in 3*3 mask
//input need to be graysacled
input  [7:0] r,g,b,
input clk,
input [12:0] col,
input [12:0] x_count,
output [7:0] out			
 );
wire signed [10:0] gx,gy;    
reg signed [10:0] abs_gx,abs_gy;	
wire [10:0] sum, sat_sum;	
reg [7:0] sat_out;

wire [7:0] p0,p1,p2,p3,p5,p6,p7,p8;

wire [23:0] pixel_in = {r, g, b};

wire row_shift_en0, row_shift_en1, row_shift_en2;
row_shift_en_gen en_gen0 (col, x_count, row_shift_en0, row_shift_en1, row_shift_en2, , , , , , , , ); 

wire [9:0] adr0, adr1, adr2, adr3;
shift_adr shiftadrs0 (col[9:0], 10'd0639, adr0, adr1, adr2, adr3, , , , , , , );

wire [23:0] row0_out, row1_out, row2_out;
wire [23:0] shift_reg_in0, shift_reg_in1, shift_reg_in2;
assign shift_reg_in0 = pixel_in;

wire shift_en = row_shift_en0;

rowRam r0 (.clk(clk), .wr_en(row_shift_en0), .addr(adr0), .rd_adr(adr1), .rd_adr2(adr1), .data_in(pixel_in), .data_out(row0_out), .data_out2());
rowRam r1 (.clk(clk), .wr_en(row_shift_en1), .addr(adr1), .rd_adr(adr2), .rd_adr2(adr0), .data_in(row0_out), .data_out(row1_out), .data_out2(shift_reg_in1));
rowRam r2 (.clk(clk), .wr_en(row_shift_en2), .addr(adr2), .rd_adr(adr3), .rd_adr2(adr0), .data_in(row1_out), .data_out(row2_out), .data_out2(shift_reg_in2));

wire [23:0] r0c0, r0c1, r0c2, 
				r1c0, r1c1, r1c2,  
				r2c0, r2c1, r2c2;

shift_reg c0 (.pixel(shift_reg_in0), .clk(clk), .shift_en(shift_en), .reg_0(r0c0), .reg_1(r0c1), .reg_2(r0c2));
shift_reg c1 (.pixel(shift_reg_in1), .clk(clk), .shift_en(shift_en), .reg_0(r1c0), .reg_1(r1c1), .reg_2(r1c2));
shift_reg c2 (.pixel(shift_reg_in2), .clk(clk), .shift_en(shift_en), .reg_0(r2c0), .reg_1(r2c1), .reg_2(r2c2));

wire [17:0] LUM0 = (8'h36 * r0c0[23:16]) + (8'hB7 * r0c0[15:8]) + (8'h12 * r0c0[7:0]);
wire [17:0] LUM1 = (8'h36 * r0c1[23:16]) + (8'hB7 * r0c1[15:8]) + (8'h12 * r0c1[7:0]);
wire [17:0] LUM2 = (8'h36 * r0c2[23:16]) + (8'hB7 * r0c2[15:8]) + (8'h12 * r0c2[7:0]);
wire [17:0] LUM3 = (8'h36 * r1c0[23:16]) + (8'hB7 * r1c0[15:8]) + (8'h12 * r1c0[7:0]);
wire [17:0] LUM5 = (8'h36 * r1c2[23:16]) + (8'hB7 * r1c2[15:8]) + (8'h12 * r1c2[7:0]);
wire [17:0] LUM6 = (8'h36 * r2c0[23:16]) + (8'hB7 * r2c0[15:8]) + (8'h12 * r2c0[7:0]);
wire [17:0] LUM7 = (8'h36 * r2c1[23:16]) + (8'hB7 * r2c1[15:8]) + (8'h12 * r2c1[7:0]);
wire [17:0] LUM8 = (8'h36 * r2c2[23:16]) + (8'hB7 * r2c2[15:8]) + (8'h12 * r2c2[7:0]);

saturate s0 ({LUM0[17:8]}, p0);
saturate s1 ({LUM1[17:8]}, p1);
saturate s2 ({LUM2[17:8]}, p2);
saturate s3 ({LUM3[17:8]}, p3);
saturate s5 ({LUM5[17:8]}, p5);
saturate s6 ({LUM6[17:8]}, p6);
saturate s7 ({LUM7[17:8]}, p7);
saturate s8 ({LUM8[17:8]}, p8);

assign gx=((p2-p0)+((p5-p3)*2)+(p8-p6));//horiz mask
assign gy=((p0-p6)+((p1-p7)*2)+(p2-p8));//verti mask

always @(*) begin
    if(gx[10]) begin
        abs_gx = ~gx + 1'b1;
    end
    else begin
        abs_gx = gx;
    end
    
    if(gy[10]) begin
        abs_gy = ~gy + 1'b1;
    end
    else begin
        abs_gy = gy;
    end
end

assign sum = (abs_gx+abs_gy);				// finding the sum
assign sat_sum = (sum[10:8])?8'hff : sum[7:0];	// saturation

always @(*) begin
    if (sat_sum <= 8'b0010011) begin
        sat_out = 0;
    end
    else begin
        sat_out = sat_sum;
    end
end

assign out = sat_out;
            
endmodule
