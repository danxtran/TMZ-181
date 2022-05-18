module greensc (
  input [7:0] r,
  input [7:0] g,
  input [7:0] b,
  input gsc_en,
  output reg [7:0] outR,
  output reg [7:0] outG,
  output reg [7:0] outB,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

assign pass_thru = pass_in;

  wire signed [24:0] greeness;
  wire signed [24:0] thresh;

  assign greeness = g*(g-r)*(g-b);
  assign thresh = 25'b0_0000_0001_0100_0011_1101_1010;
 
  always @(*)begin
		outR = r;
		outG = g;
		outB = b;
		if(gsc_en == 1'b1)begin
			if(greeness > thresh) begin
				outR = 8'b0000_0000;
				outG = 8'b0000_0000;
				outB = 8'b0000_0000;
			end 
		end
  end
endmodule
