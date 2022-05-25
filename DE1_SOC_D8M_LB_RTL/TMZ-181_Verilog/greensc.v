module greensc (
  input gsc_en,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

assign pass_thru = pass_in;
 
  always @(*)begin
		pixel_out = pixel_in;
		if(gsc_en == 1'b1)begin
			if(pixel_in[23:15] >= 9'd90 && pixel_in[23:15] <= 9'd150) begin
				pixel_out[23:15] = 8'h00;
			end 
		end
  end
endmodule
