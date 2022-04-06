module brightness (
  input clk,
  input enable, // master enable
  input frame_en, // frame update signal
  input rst,
  input inc, // increase brightness signal
  input dec, // decrease brightness signal
  input [7:0] R,
  input [7:0] G,
  input [7:0] B,
  output [7:0] outR,
  output [7:0] outG,
  output [7:0] outB
);


reg [3:0] level, level_c; // brightness level
reg [12:0] Rp, Gp, Bp; // resulting products
reg [7:0] Rs, Gs, Bs; // saturated values
reg en, en_c; // enable stuff


//saturation handling
saturate r (Rp[12:3], Rs);
saturate g (Gp[12:3], Gs);
saturate b (Bp[12:3], Bs);


always @(*) begin
  en_c = enable; //enable handling

  outR = R; // default output to input
  outG = G;
  outB = B;
  
  // multiplication handling
  Rp = R * level;
  Gp = G * level;
  Bp = B * level;
  
  if (en == 1'b1) begin // logic if module enabled
    // level handling
    if (level_c == level) begin
      if (inc == 1'b1 && level < 4'hF) begin
	     level_c = level + 1'b1;
	   end
	   else if (dec == 1'b1 && level > 4'h0) begin
	     level_c = level - 1'b1;
	   end
    end
    //output saturated values
    outR = Rs;
	 outG = Gs;
	 outB = Bs;
  end
  
  if (rst == 1'b1) begin // reset logic
    level_c = 4'h8;
	 en_c = 1'b0;
  end
end


always @(posedge clk) begin
  if (frame_en == 1'b1 || rst == 1'b1) begin // module enable logic
    en <= #1 en_c;
  end

  if (en == 1'b1 || rst == 1'b1) begin // only update if enabled or rst is asserted
    if (frame_en == 1'b1 || rst == 1'b1) begin
	   level <= #1 level_c; // update brightness level when new frame arrives
	 end
  end
end


endmodule
