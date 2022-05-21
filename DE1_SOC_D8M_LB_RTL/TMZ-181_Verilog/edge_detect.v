module edge_detect ( //module to use for top level
  input clk,
  input rst,
  input [12:0] col,
  input [12:0] x_count,
  input [3:0] filt_sel,
  input en,
  output [7:0] cartoon_edge,
  output [23:0] cartoon_blur,
  input [23:0] pixel_in,
  output [23:0] pixel_out,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

wire [7:0] r, g, b, out_r0, out_r1, out_g0, out_g1, out_b0, out_b1;
wire [23:0] pass0, cartoon_blur_pass;

hsv_rgb r0 (pixel_in, r, g, b);
rgb_hsv h0 (out_r1, out_g1, out_b1, pixel_out);
rgb_hsv cblur (cartoon_blur_pass[23:16], cartoon_blur_pass[15:8], cartoon_blur_pass[7:0], cartoon_blur);

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
.pass_thru(pass0)
);

sobel_edge_det sed(
.clk(clk),
.r(out_r0),
.g(out_g0),
.b(out_b0),
.col(col),
.x_count(x_count),
.en(en),
.cartoon_edge(cartoon_edge),
.cartoon_blur(cartoon_blur_pass),
.outR(out_r1),
.outG(out_g1),
.outB(out_b1),
.pass_in(pass0),
.pass_thru(pass_thru)
);

endmodule
