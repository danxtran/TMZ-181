`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module lvl2pulse ( // simple level to pulse generator
  input clk,
  input in,
  output reg out
);

reg out_c, in_old;

always @(*) begin
  out_c = 1'b0;
  if (in_old == 1'b0 && in == 1'b1) begin
    out_c = 1'b1;
  end
end

always @(posedge clk) begin
  out <= #1 out_c;
  in_old <= #1 in;
end

endmodule
