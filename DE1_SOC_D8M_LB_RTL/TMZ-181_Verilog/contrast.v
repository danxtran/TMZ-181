`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module contrast (
  input clk,
  input rst,
  input inc, // increase contrast signal
  input dec, // decrease contrast signal
  input [23:0] pixel_in,
  output [23:0] pixel_out,
  input [23:0] pass_in,
  output [23:0] pass_thru,
  output [3:0] level_out
);

assign pixel_out[23:8] = pixel_in[23:8]; 
assign pass_thru = pass_in;
assign level_out = level;

reg [3:0] level, level_c; // contrast level
wire [12:0] product; // resulting products

// contrast calculations
contrast_logic cl (pixel_in[7:0], level, product);

//saturation handling
saturate V (product[9:0], pixel_out[7:0]);

initial begin
  level = 4'h8;
end

always @(*) begin
  
  level_c = 4'b1000;
  
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


module contrast_logic ( // used to calculate values for contrast module
  input [7:0] in,
  input [3:0] level,
  output reg [12:0] out
);

parameter MID = 8'h80;

wire [7:0] high = in - MID;
wire [7:0] low = MID - in;

always @(*) begin
  out = in; // middle values don't change
  
  if (in > MID) begin // logic for higher values
    out = MID + ((high * level)>>3);
  end
  else if (in < MID) begin // logic for smaller values
    out = 13'h0000;
	 if (((low * level)>>3) <= MID) begin
	   out = MID - ((low * level)>>3);
	 end
  end
  
end

endmodule
