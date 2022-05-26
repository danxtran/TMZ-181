module cursor (
  input clk,
  input [12:0] col,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in
);

reg [23:0] pixel_out_c;

always @(*) begin
  pixel_out_c = pixel_in;
  if (col < 13'd320) begin
    pixel_out_c = pass_in;
  end
end

always @(posedge clk) begin
  pixel_out <= #1 pixel_out_c; 
end

endmodule
