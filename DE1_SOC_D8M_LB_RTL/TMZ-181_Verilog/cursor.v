module cursor (
  input col,
  input [7:0] r,
  input [7:0] g,
  input [7:0] b,
  input [23:0] pass_in,
  output reg [7:0] outR,
  output reg [7:0] outG,
  output reg [7:0] outB
);

always @(*) begin
  outR = r;
  outG = g;
  outB = b;
  if (col < 13'd320) begin
    outR = pass_in[23:16];
	 outG = pass_in[15:8];
	 outB = pass_in[7:0];
  end
end

endmodule
