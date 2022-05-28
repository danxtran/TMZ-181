module cartoon (
   input clk,
	input [7:0] cartoon_edge,
	input [23:0] cartoon_blur,
	input en,
   input [23:0] pixel_in,
   output reg [23:0] pixel_out,
	input [23:0] pass_in,
   output reg [23:0] pass_thru
);

reg [23:0] pixel_out_c;

wire [9:0] sat = {cartoon_blur[14:8], 1'b0} + 10'd50; //increase saturation value
wire [7:0] S;

saturate s0 (sat, S);

always @(*) begin
  pixel_out_c = pixel_in;
  
  if (en == 1'b1) begin
    pixel_out_c[23:0] = cartoon_blur[23:0];
    if (cartoon_edge <= 8'h40) begin //increase saturation of color pixels
	   pixel_out_c[14:8] = S[7:1];
	 end
	 else begin //set pixel value to black if edge
	   pixel_out_c[7:0] = 8'h00;
	 end
  end
  
end

always @(posedge clk) begin
  pixel_out <= #1 pixel_out_c;
  pass_thru <= #1 pass_in; 
end

endmodule
