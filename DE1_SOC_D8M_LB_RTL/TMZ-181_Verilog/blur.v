module blur ( //module to use for top level
  input clk,
  input rst,
  input [12:0] col,
  input [12:0] x_count,
  input [3:0] filt_sel,
  input [23:0] pixel_in,
  output [23:0] pixel_out,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

wire [7:0] r, g, b, out_r0, out_g0, out_b0;

hsv_rgb r0 (pixel_in, r, g, b);
rgb_hsv h0 (out_r0, out_g0, out_b0, pixel_out);

gauss gs1(
.clk(clk),
.rst(rst),
.r(r),
.g(g),
.b(b),
.col(col),
.x_count(x_count),
.filt_sel(filt_sel),
.outR(out_r0),
.outG(out_g0),
.outB(out_b0),
.pass_in(pass_in),
.pass_thru(pass_thru)
);


endmodule
