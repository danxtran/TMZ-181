`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module grayscale (
  input clk,
  input rst,
  input en,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in,
  output reg [23:0] pass_thru
);

reg  [6:0]  sat;
wire [23:0] pixel_out_c;


assign pixel_out_c[23:15] = pixel_in[23:15]; 
assign pixel_out_c[7:0] = pixel_in[7:0];
assign pixel_out_c[14:8] = sat;
reg enable, en_c;

always @(*) begin
  sat = pixel_in[14:8];
  en_c = en;
  
  if (enable == 1'b1) begin
    sat = 7'b0000_000;
  end
  
  if (rst == 1'b1) begin //reset logic
    en_c = 1'b0;
  end
end


always @(posedge clk) begin
    enable <= #1 en_c;
	 pixel_out <= #1 pixel_out_c;
	 pass_thru <= #1 pass_in; 
end

endmodule
