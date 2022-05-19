module owo ();
// OUR CODE
wire [23:0] HSV;
wire [7:0] raw_VGA_R, raw_VGA_G, raw_VGA_B, VGA_R, VGA_G, VGA_B;
rgb_hsv h0 (raw_VGA_R, raw_VGA_G, raw_VGA_B, HSV);
hsv_rgb r0 (HSV, VGA_R, VGA_G, VGA_B);
endmodule