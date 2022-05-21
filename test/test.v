module owo ();
// OUR CODE
wire [23:0] HSV;
reg [7:0] raw_VGA_R, raw_VGA_G, raw_VGA_B;
wire [7:0] VGA_R, VGA_G, VGA_B;
rgb_hsv h0 (raw_VGA_R, raw_VGA_G, raw_VGA_B, HSV);
hsv_rgb r0 (HSV, VGA_R, VGA_G, VGA_B);


initial begin
raw_VGA_R = 8'hFF;
raw_VGA_G = 8'hF0;
raw_VGA_B = 8'h0F;

#100
raw_VGA_R = 8'hFF;
raw_VGA_G = 8'h0F;
raw_VGA_B = 8'hF0;

end


endmodule
