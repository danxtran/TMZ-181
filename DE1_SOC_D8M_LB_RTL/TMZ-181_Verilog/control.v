module control ( // control module
  input clk,
  input rst,
  input [9:0] SW,
  input [3:0] KEY,
  input [12:0] row,
  input [12:0] col,
  output [31:0] en, // enable signals ******UPDATE BIT SIZE WHEN FINISHED*****
  output reg frame_en,
  
  //brightness signals
  output reg binc, // increase brightness signal
  output reg bdec, // decrease brightness signal
  
  //contrast signals
  output reg cinc, // increase contrast signal
  output reg cdec // decrease contrast signal
);
/* enable signal bits
0 - brightness

*/

// master logic vars & modules
parameter rowMax = 13'd0480;
parameter colMax = 13'd0640;
reg frame_en_c;

//brightness vars & modules
wire incb, decb;
lvl2pulse INCb (clk, KEY[0], incb);
lvl2pulse DECb (clk, KEY[1], decb);

always @(*) begin
  //master logic
  frame_en_c = 1'b0; // frame enable logic - enables once when switching to new frame
  if (row == rowMax && col == colMax) begin
    frame_en_c = 1'b1;
  end

  //brightness logic
  binc = 1'b0;
  bdec = 1'b0;
  if (SW[1] == 1'b1) begin
    binc = incb;
	 bdec = decb;
  end

end


always @(posedge clk) begin
  frame_en <= #1 frame_en_c;
end

endmodule
