`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module brightness (
  input clk,
  input rst,
  input inc, // increase brightness signal
  input dec, // decrease brightness signal
  input [7:0] r,
  input [7:0] g,
  input [7:0] b,
  output [7:0] outR,
  output [7:0] outG,
  output [7:0] outB,
  input [23:0] pass_in,
  output [23:0] pass_thru,
  output [3:0] level_out
);

assign pass_thru = pass_in;
assign level_out = level;

reg [3:0] level, level_c; // brightness level
reg [12:0] Rp, Gp, Bp; // resulting products

//saturation handling
saturate R (Rp[12:3], outR);
saturate G (Gp[12:3], outG);
saturate B (Bp[12:3], outB);

initial begin
  level = 4'h8;
end

always @(*) begin
  
  // multiplication handling
  Rp = r * level;
  Gp = g * level;
  Bp = b * level;
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
