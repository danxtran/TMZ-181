module saturate ( //module to handle saturation
  input [9:0] in, // 10 bit input
  output reg [7:0] out // 8 bit output
);

always @(*) begin
  out = in[7:0]; // output LSBs
  if (in >= 8'hFF) begin
    out = 8'hFF; // output max 255 value if over max value
  end
end

endmodule