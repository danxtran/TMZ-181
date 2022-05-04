module sobel_edge_det(
//p0 - p8 :8 pixel sourding by the target pixel in 3*3 mask
//input need to be graysacled
input  [7:0] r,g,b,
input clk,
input [12:0] col,
input buff_en,
input shift_en,
output [7:0] out;				
 );
wire signed [10:0] gx,gy;    
reg signed [10:0] abs_gx,abs_gy;	
wire [10:0] sum, sat_sum;	
reg [7:0] sat_out;
reg [7:0] buff [639:0] [2:0];
reg [7:0] shift [10:0] [639:0] [2:0];
integer color, column;
wire [7:0] p0,p1,p2,p3,p5,p6,p7,p8;

wire [17:0] LUM0 = (8'h36 * shift[0][col-1][0]) + (8'h12 * shift[0][col-1][1]) + (8'hB7 * shift[0][col-1][2]);
wire [17:0] LUM1 = (8'h36 * shift[0][col][0]) + (8'h12 * shift[0][col][1]) + (8'hB7 * shift[0][col][2]);
wire [17:0] LUM2 = (8'h36 * shift[0][col+1][0]) + (8'h12 * shift[0][col+1][1]) + (8'hB7 * shift[0][col+1][2]);
wire [17:0] LUM3 = (8'h36 * shift[1][col-1][0]) + (8'h12 * shift[1][col-1][1]) + (8'hB7 * shift[1][col-1][2]);
wire [17:0] LUM5 = (8'h36 * shift[1][col+1][0]) + (8'h12 * shift[1][col+1][1]) + (8'hB7 * shift[1][col+1][2]);
wire [17:0] LUM6 = (8'h36 * shift[2][col-1][0]) + (8'h12 * shift[2][col-1][1]) + (8'hB7 * shift[2][col-1][2]);
wire [17:0] LUM7 = (8'h36 * shift[2][col][0]) + (8'h12 * shift[2][col][1]) + (8'hB7 * shift[2][col][2]);
wire [17:0] LUM8 = (8'h36 * shift[2][col+1][0]) + (8'h12 * shift[2][col+1][1]) + (8'hB7 * shift[2][col+1][2]);

saturate s0 ({1'b0, LUM0[17:9]}, p0);
saturate s1 ({1'b0, LUM1[17:9]}, p1);
saturate s2 ({1'b0, LUM2[17:9]}, p2);
saturate s3 ({1'b0, LUM3[17:9]}, p3);
saturate s5 ({1'b0, LUM5[17:9]}, p5);
saturate s6 ({1'b0, LUM6[17:9]}, p6);
saturate s7 ({1'b0, LUM7[17:9]}, p7);
saturate s8 ({1'b0, LUM8[17:9]}, p8);

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
assign sat_sum = (|sum[10:8])?8'hff : sum[7:0];	// saturation

always @(*) begin
    if (sat_sum <= 8'b0010011) begin
        sat_out = 0;
    end
    else begin
        sat_out = sat_sum;
    end
end

assign out = sat_out;
    
always @(posedge clk) begin
	if( buff_en == 1'b1) begin
		buff[col][0] <= #1 r;
		buff[col][1] <= #1 g;
		buff[col][2] <= #1 b;
	end
	if(shift_en == 1'b1) begin
		for(color = 0; color < 3; color = color + 1)begin
			for(column = 0; column < 640; column = column + 1) begin
				shift[0][column][color] <= #1 buff[column][color];
				shift[1][column][color] <= #1 shift[0][column][color];
				shift[2][column][color] <= #1 shift[1][column][color];
			end
		end
	end
	
end        
endmodule
