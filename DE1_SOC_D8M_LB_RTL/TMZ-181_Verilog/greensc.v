module greensc (
  input [7:0] in_r,
  input [7:0] in_g,
  input [7:0] in_b,
  input gsc_en,
  output reg [7:0] gsc_out_r,
  output reg [7:0] gsc_out_g,
  output reg [7:0] gsc_out_b
);

  wire signed [24:0] greeness;
  wire signed [24:0] thresh;

  assign greeness = in_g*(in_g-in_r)*(in_g-in_b);
  assign thresh = 25'b0_0000_0001_0100_0011_1101_1010;
 
//  assign out_r = (greeness > thresh) ? 8'b0000_0000 : in_r;
//  assign out_g = (greeness > thresh) ? 8'b0000_0000 : in_g;
//  assign out_b = (greeness > thresh) ? 8'b0000_0000 : in_b;
  always @(*)begin
		gsc_out_r = in_r;
		gsc_out_g = in_g;
		gsc_out_b = in_b;
		if(gsc_en == 1'b1)begin
			if(greeness > thresh) begin
				gsc_out_r = 8'b0000_0000;
				gsc_out_g = 8'b0000_0000;
				gsc_out_b = 8'b0000_0000;
			end 
		end
  end
endmodule
