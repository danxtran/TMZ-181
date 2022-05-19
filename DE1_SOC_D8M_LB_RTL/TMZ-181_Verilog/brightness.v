`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module brightness (
  input clk,
  input rst,
  input inc, // increase brightness signal
  input dec, // decrease brightness signal
  input [23:0] pixel_in,
  output [23:0] pixel_out,
  input [23:0] pass_in,
  output [23:0] pass_thru,
  output [3:0] level_out
);

assign pixel_out[23:8] = pixel_in[23:8]; 
assign pass_thru = pass_in;
assign level_out = level;
wire [12:0] product = pixel_in[7:0] * level;

reg [3:0] level, level_c; // brightness level

//saturation handling
saturate V (product[12:3], pixel_out[7:0]);

initial begin
  level = 4'h8;
end

always @(*) begin
  
  level_c = 4'h8;

  // level handling
  if (inc == 1'b1 && level < 4'hF) begin
    level_c = level + 1'b1;
  end
  else if (dec == 1'b1 && level > 4'h0) begin
    level_c = level - 1'b1;
  end
  else begin
    level_c = level;
  end

  if (rst == 1'b1) begin // reset logic
    level_c = 4'h8;
  end
  
end


always @(posedge clk) begin
  level <= #1 level_c; // update brightness level
end


endmodule
