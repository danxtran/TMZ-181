module mod360 (
  input [10:0] in,
  output [8:0] out
);

reg [10:0] out_c;
assign out = out_c[8:0];
  
always @(*) begin
  if (in >= 11'd1080) begin
    out_c = in - 11'd1080;
  end
  else if (in >= 11'd720) begin
    out_c = in - 11'd720;
  end
  else if (in >= 11'd360) begin
    out_c = in - 11'd360;
  end
  else begin
    out_c = in;
  end

end

endmodule
