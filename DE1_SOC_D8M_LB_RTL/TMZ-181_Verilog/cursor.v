module cursor (
  input [12:0] col,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in
);

always @(*) begin
  pixel_out = pixel_in;
  if (col < 13'd320) begin
    pixel_out = pass_in;
  end
end

endmodule
