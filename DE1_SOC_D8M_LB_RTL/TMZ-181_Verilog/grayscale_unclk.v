module grayscale_unclk (
  input [7:0] in_R,
  input [7:0] in_G,
  input [7:0] in_B,
  output [7:0] out_R,
  output [7:0] out_G,
  output [7:0] out_B   
);

reg  [17:0]  LUM;
wire  [7:0]  sat_LUM;

always @(*) begin
  
    LUM = (8'h36 * in_R) + (8'hB7 * in_B) + (8'h12 * in_G); // lumience calculation
  end
  saturate LUM_sat ({1'b0, LUM[17:9]}, sat_LUM); // saturate the LUM value
	assign out_R = sat_LUM; // set outputs to saturated lumience values
  assign out_G = sat_LUM;
  assign out_B = sat_LUM;
endmodule
