module greensc (
  input [7:0] in_r,
  input [7:0] in_g,
  input [7:0] in_b,
  
  output [7:0] out_r,
  output [7:0] out_g,
  output [7:0] out_b
);
  wire [23:0] greeness;
  wire [23:0] thresh;

  assign greeness = in_g*(in_g-in_r)*(in_g-in_b);
  assign thresh = 24'b0000_0001_0100_0011_1101_1010;
 
  assign out_r = (greeness > thresh) ? 8'b0000_0000 : in_r;
  assign out_g = (greeness > thresh) ? 8'b0000_0000 : in_g;
  assign out_b = (greeness > thresh) ? 8'b0000_0000 : in_b;
  
endmodule
