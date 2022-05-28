`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module owo ();
// OUR CODE
reg MIPI_PIXEL_CLK_;
reg [9:0] SW;
reg [3:0] KEY;
wire [23:0] HSV;
reg [7:0] raw_VGA_R, raw_VGA_G, raw_VGA_B;
wire [7:0] VGA_R, VGA_G, VGA_B;

wire [23:0] pass0, pass1, pass2, pass3, pass4, pass5, pass6, pass7, pass8;
wire [23:0] pixel0, pixel1, pixel2, pixel3, pixel4, pixel5, pixel6, pixel7, pixel8, pixel9;
assign pass0 = pixel0;

rgb_hsv h0 (raw_VGA_R, raw_VGA_G, raw_VGA_B, pixel0);
hsv_rgb r0 (pixel9, VGA_R, VGA_G, VGA_B);

wire [7:0] cartoon_edge;
wire [23:0] cartoon_blur;
wire rst = SW[9];
wire clk = MIPI_PIXEL_CLK_;
wire [31:0] en;
wire binc, bdec, cinc, cdec;
wire [3:0] clr_sel, gauss_sel, edge_gauss_sel;
wire [3:0] level_out;

control ctrl(
.clk(clk),
.rst(rst),
.SW(SW[9:0]),
.KEY(KEY[3:0]),
.row(row),
.col(col),
.x_count(x_count),
.y_count(y_count),
.en(en),
.binc(binc),
.bdec(bdec),
.cinc(cinc),
.cdec(cdec),
.clr_sel(clr_sel),
.gauss_sel(gauss_sel),
.edge_gauss_sel(edge_gauss_sel)
);

edge_detect edge_det0 (
.clk(clk),
.rst(rst),
.col(col),
.x_count(x_count),
.filt_sel(edge_gauss_sel),
.en(en[5]),
.cartoon_edge(cartoon_edge),
.cartoon_blur(cartoon_blur),
.pixel_in(pixel0),
.pixel_out(pixel1),
.pass_in(pass0),
.pass_thru(pass1)
);


cartoon cartoon1(
.cartoon_edge(cartoon_edge),
.cartoon_blur(cartoon_blur),
.en(en[2]),
.pixel_in(pixel1),
.pixel_out(pixel2),
.pass_in(pass1),
.pass_thru(pass2)
);

colordetc colodetc1(
.clk(clk),
.rst(rst),
.clr_sel(clr_sel),
.pixel_in(pixel2),
.pixel_out(pixel3),
.pass_in(pass2),
.pass_thru(pass3)
);

greensc greensc1(
.gsc_en(en[4]),
.pixel_in(pixel3),
.pixel_out(pixel4),
.pass_in(pass3),
.pass_thru(pass4)
);

blur gs2(
.clk(clk),
.rst(rst),
.col(col),
.x_count(x_count),
.filt_sel(gauss_sel),
.pixel_in(pixel4),
.pixel_out(pixel5),
.pass_in(pass4),
.pass_thru(pass5)
);

grayscale grayscale1(
.clk(clk),
.rst(rst),
.en(en[3]),
.pixel_in(pixel5),
.pixel_out(pixel6),
.pass_in(pass5),
.pass_thru(pass6)
);

brightness brightness1(
.clk(clk),
.rst(rst),
.inc(binc),
.dec(bdec),
.pixel_in(pixel6),
.pixel_out(pixel7),
.pass_in(pass6),
.pass_thru(pass7),
.level_out(level_out)
);

contrast contrast1(
.clk(clk),
.rst(rst),
.inc(cinc),
.dec(cdec),
.pixel_in(pixel7),
.pixel_out(pixel8),
.pass_in(pass7),
.pass_thru(pass8),
.level_out(level_out)
);

cursor cursor1(
.col(col),
.pixel_in(pixel8),
.pixel_out(pixel9),
.pass_in(pass8)
);

initial begin
raw_VGA_R = 8'hFF;
raw_VGA_G = 8'hF0;
raw_VGA_B = 8'h0F;

end


endmodule
