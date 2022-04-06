module grayscale (
  input clk,
  input rst,
  input enable,
  input frame_en,
  input [7:0] in_R,
  input [7:0] in_G,
  input [7:0] in_B,
  output reg [7:0] out_R,
  output reg [7:0] out_G,
  output reg [7:0] out_B   
);

reg  [17:0]  LUM;
wire  [7:0]  sat_LUM;
reg en, en_c;

saturate LUM_sat ({1'b0, LUM[17:9]}, sat_LUM); // saturate the LUM value

always @(*) begin
  out_R = in_R;
  out_G = in_G;
  out_B = in_B;
  en_c = enable;
  
  if (en == 1'b1) begin
    LUM = (8'h36 * in_R) + (8'hB7 * in_B) + (8'h12 * in_G); // lumience calculation
	 
	 out_R = sat_LUM; // set outputs to saturated lumience values
    out_G = sat_LUM;
    out_B = sat_LUM;
  end
  
  if (rst == 1'b1) begin //reset logic
    en_c = 1'b0;
  end
end


always @(posedge clk) begin
  if (frame_en == 1'b1 || rst == 1'b1) begin
    en <= #1 en_c;
  end
end

endmodule
