module mod360 (
  input [8:0] in,
  output reg [8:0] out
);


always @(*) begin

  if (in >= 14'd360) begin
    out = in - 14'd360;
  end
  else begin
    out = in;
  end

end

endmodule
