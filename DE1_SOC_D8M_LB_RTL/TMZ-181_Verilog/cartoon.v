module cartoon (
	input [7:0] r,
	input [7:0] g,
	input [7:0] b,
	input [7:0] cartoon_edge,
	input [23:0] cartoon_blur,
	input en,
	output reg [7:0] outR,
   output reg [7:0] outG,
   output reg [7:0] outB,
	input [23:0] pass_in,
   output [23:0] pass_thru
);

assign pass_thru = pass_in;

always @(*) begin
  outR = r;
  outG = g;
  outB = b;
  
  if (en == 1'b1) begin
    if (cartoon_edge == 8'h00) begin 
      outR = cartoon_blur[23:16];
	   outG = cartoon_blur[15:8];
	   outB = cartoon_blur[7:0];
	 end
	 else begin
	   outR = 8'h00;
	   outG = 8'h00;
	   outB = 8'h00;
	 end
  end
  
end

endmodule
