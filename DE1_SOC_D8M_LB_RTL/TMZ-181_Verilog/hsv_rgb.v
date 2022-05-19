module hsv_rgb (
  input [23:0] hsv,
  output [7:0] outR,
  output [7:0] outG,
  output [7:0] outB
);

wire [8:0] S, V;

divide ds ({hsv[14:8], 1'b0}, 8'hFE , S);
divide dv (hsv[7:0], 8'hFF, V);

wire [17:0] Ctemp = S * V;
wire [8:0] C = Ctemp[16:8];
wire [24:0] Xtemp = hsv[23:15] * 16'h9999;
reg [16:0] Xtemp1;
wire [16:0] Xtemp2 = 17'd65536 - Xtemp1;
wire [25:0] Xtemp3 = C * Xtemp2;
wire [8:0] X = Xtemp3[24:16];
wire [8:0] m = V - C;
wire [17:0] r, g, b;
reg [8:0] rtemp, gtemp, btemp;

assign r = (rtemp + m) * 8'hFF;
assign g = (gtemp + m) * 8'hFF;
assign b = (btemp + m) * 8'hFF;
assign outR = r[15:8];
assign outG = g[15:8];
assign outB = b[15:8];

always @(*) begin
  if (Xtemp[16] == 1'b1) begin
    Xtemp1 = {1'b0, Xtemp[15:0]};
  end
  else begin
    Xtemp1 = 17'd65536 - Xtemp[15:0];
  end
  
  rtemp = 9'h000;
  gtemp = 9'h000;
  btemp = 9'h000;
  if (hsv[23:15] >= 9'd0 && hsv[23:15] < 9'd60) begin
    rtemp = C;
	 gtemp = X;
	 btemp = 9'h000;
  end
  else if (hsv[23:15] >= 9'd60 && hsv[23:15] < 9'd120) begin
    rtemp = X;
	 gtemp = C;
	 btemp = 9'h000;
  end
  else if (hsv[23:15] >= 9'd120 && hsv[23:15] < 9'd180) begin
    rtemp = 9'h000;
	 gtemp = C;
	 btemp = X;
  end
  else if (hsv[23:15] >= 9'd180 && hsv[23:15] < 9'd240) begin
    rtemp = 9'h000;
	 gtemp = X;
	 btemp = C;
  end
  else if (hsv[23:15] >= 9'd240 && hsv[23:15] < 9'd300) begin
    rtemp = X;
	 gtemp = 9'h000;
	 btemp = C;
  end
  else if (hsv[23:15] >= 9'd300 && hsv[23:15] < 9'd360) begin
    rtemp = C;
	 gtemp = 9'h000;
	 btemp = X;
  end

end

endmodule
