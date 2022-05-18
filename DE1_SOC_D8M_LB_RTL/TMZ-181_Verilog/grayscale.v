`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module grayscale (
  input clk,
  input rst,
  input en,
  input [7:0] r,
  input [7:0] g,
  input [7:0] b,
  output reg [7:0] outR,
  output reg [7:0] outG,
  output reg [7:0] outB,
  input [23:0] pass_in,
  output [23:0] pass_thru
);

assign pass_thru = pass_in;

reg  [17:0]  LUM;
wire  [7:0]  sat_LUM;
reg enable, en_c;

saturate LUM_sat ({1'b0, LUM[17:9]}, sat_LUM); // saturate the LUM value

always @(*) begin
  outR = r;
  outG = g;
  outB = b;
  en_c = en;
  
  if (enable == 1'b1) begin
    LUM = (8'h36 * r) + (8'hB7 * b) + (8'h12 * g); // lumience calculation
	 
	 outR = sat_LUM; // set outputs to saturated lumience values
    outG = sat_LUM;
    outB = sat_LUM;
  end
  
  if (rst == 1'b1) begin //reset logic
    en_c = 1'b0;
  end
end


always @(posedge clk) begin
    enable <= #1 en_c;
end

endmodule
