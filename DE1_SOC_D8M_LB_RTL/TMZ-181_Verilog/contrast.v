`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module contrast (
  input clk,
  input enable, // master enable
  input frame_en, // frame update signal
  input rst,
  input inc, // increase contrast signal
  input dec, // decrease contrast signal
  input [7:0] R,
  input [7:0] G,
  input [7:0] B,
  output reg [7:0] outR,
  output reg [7:0] outG,
  output reg [7:0] outB
);


reg [3:0] level, level_c; // contrast level
wire [12:0] Rp, Gp, Bp; // resulting products
wire [7:0] Rs, Gs, Bs; // saturated values
reg en, en_c; // enable stuff

// contrast calculations
contrast_logic cr (R, level, Rp);
contrast_logic cg (G, level, Gp);
contrast_logic cb (B, level, Bp);

//saturation handling
saturate r (Rp[9:0], Rs);
saturate g (Gp[9:0], Gs);
saturate b (Bp[9:0], Bs);


always @(*) begin
  en_c = enable; //enable handling

  outR = R; // default output to input
  outG = G;
  outB = B;
  
  level_c = 4'b1000;
  
  if (en == 1'b1) begin // logic if module enabled
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

		 //output saturated values
		 outR = Rs;
		 outG = Gs;
		 outB = Bs;
  end
  else level_c = level;
  if (rst == 1'b1) begin // reset logic
    level_c = 4'h8;
	 en_c = 1'b0;
  end
  
end


always @(posedge clk) begin
//  if (frame_en == 1'b1 || rst == 1'b1) begin // module enable logic
    en <= #1 en_c;
//  end

  if (en == 1'b1 || rst == 1'b1) begin // only update if enabled or rst is asserted
//    if (frame_en == 1'b1 || rst == 1'b1) begin
	   level <= #1 level_c; // update contrast level when new frame arrives
//	 end
  end
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
