`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module grayscale (
  input clk,
  input rst,
  input en,
  input [23:0] pixel_in,
  output [23:0] pixel_out,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

assign pixel_out[23:15] = pixel_in[23:15]; 
assign pixel_out[7:0] = pixel_in[7:0];
assign pixel_out[14:8] = sat;
assign pass_thru = pass_in;
reg enable, en_c;

reg  [6:0]  sat;



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
end

endmodule
