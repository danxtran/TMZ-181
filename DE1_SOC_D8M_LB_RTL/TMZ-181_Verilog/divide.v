module divide (
  input [7:0] num,
  input [7:0] dem,
  output [8:0] ans
);

wire [15:0] next7, next6, next5, next4, next3, next2, next1, next0;

div_step d8 ({8'h00, num}, dem, ans[8], next7);
div_step d7 (next7, dem, ans[7], next6);
div_step d6 (next6, dem, ans[6], next5);
div_step d5 (next5, dem, ans[5], next4);
div_step d4 (next4, dem, ans[4], next3);
div_step d3 (next3, dem, ans[3], next2);
div_step d2 (next2, dem, ans[2], next1);
div_step d1 (next1, dem, ans[1], next0);
div_step d0 (next0, dem, ans[0], );

endmodule

module div_step (
  input [15:0] top,
  input [7:0] bot,
  output reg Q,
  output reg [15:0] next
);

wire [15:0] diff = top - bot;

always @(*) begin
  Q = 1'b0;
  next = top << 1;
  if (top >= bot) begin
    Q = 1'b1;
    next = {diff[13:0], 1'b0};
  end
end

endmodule