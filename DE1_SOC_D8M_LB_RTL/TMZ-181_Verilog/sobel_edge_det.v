module sobel_edge_det( p0, p1, p2, p3, p5, p6, p7, p8, out);
//p0 - p8 :8 pixel sourding by the target pixel in 3*3 mask
input  [7:0] p0,p1,p2,p3,p5,p6,p7,p8;
output [7:0] out;				

wire signed [10:0] gx,gy;    
reg signed [10:0] abs_gx,abs_gy;	
wire [10:0] sum, sat_sum;	
reg [7:0] sat_out;

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
    
        
endmodule
