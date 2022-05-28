`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module control ( // control module
  input clk,
  input rst,
  input [9:0] SW,
  input [3:0] KEY,
  output reg [3:0] en, // enable signals
  
  //brightness signals
  output reg binc, // increase brightness signal
  output reg bdec, // decrease brightness signal
  
  //contrast signals
  output reg cinc, // increase contrast signal
  output reg cdec, // decrease contrast signal
  
  //saturation signals
  output reg sinc, // increase saturation signal
  output reg sdec, // decrease saturation signal
  
  //color select signal
  output reg [3:0] clr_sel,
  
  //green screen bg select
  output reg [3:0] gs_bg_sel,
  
  //gauss select signal
  output reg [3:0] gauss_sel,
  
  //edge detect signals
  output reg [3:0] edge_gauss_sel,
  
  //cursor signals
  output reg [3:0] move,
  output reg [3:0] size,
  output reg [1:0] mode
);

/* enable signal bits
0 - Green Screen
1 - Cartoon Effect
2 - Edge Detect
3 - Grayscale
*/
/* Module Switch Usage
0 - RST (Camera)
1 - N/A
2 - Green Screen
3 - Cartoon Effect
4 - Edge Detect
5 - Grayscale
678 switches
  0 - Brightness/Contrast
  1 - Saturation
  2 - Blur
  3 - Color Det
  4 - Green Screen BG select
  5 - Cursor Move
  6 - Cursor Size
  7 - Cursor Mode
9 - RST (modules)
*/

// master logic vars & modules
parameter rowMax = 13'd0480;
parameter colMax = 13'd0640;
reg [3:0] en_c;

//level to pulse button modules
wire bll, bl;//left buttons
wire br, brr;//right buttons
lvl2pulse b3 (clk, KEY[3], bll);
lvl2pulse b2 (clk, KEY[2], bl);
lvl2pulse b1 (clk, KEY[1], br);
lvl2pulse b0 (clk, KEY[0], brr);

//gauss blur vars & modules
reg gauss1, gauss2, gauss3, gauss4;

//color detect vars & modules
reg clr1, clr2, clr3, clr4;

//green screen bg vars & modules
reg bg1, bg2, bg3, bg4;

//cursor vars & modules
reg size1, size2, size3, size4;



always @(*) begin

  //enable signals default
  en_c = 4'h0;

  //green screen logic
  if(SW[2] == 1'b1)begin
    en_c[0] = 1'b1;
  end else begin
    en_c[0] = 1'b0;
  end
  
  //cartoon effect logic
  edge_gauss_sel = 4'h1;
  if(SW[3] == 1'b1)begin
    edge_gauss_sel = 4'h2;
    en_c[1] = 1'b1;
    en_c[2] = 1'b1;
  end
  
  //edge detect on
  if(SW[4] == 1'b1)begin
    en_c[2] = 1'b1;
  end
  
  // grayscale on
  if(SW[5] == 1'b1)begin
    en_c[3] = 1'b1;
  end else begin
    en_c[3] = 1'b0;
  end
  
  //brightness & contrast logic
  binc = 1'b0;
  bdec = 1'b0;
  cinc = 1'b0;
  cdec = 1'b0;
  if (SW[8:6] == 3'b0) begin
    binc = bll;
	 bdec = bl;
	 cinc = br;
	 cdec = brr;
  end
  
  //saturation logic
  sinc = 1'b0;
  sdec = 1'b0;
  if (SW[8:6] == 3'b001) begin
	 sinc = br;
	 sdec = brr;
  end
	
  // gauss blur logic
  gauss1 = 1'b0;
  gauss2 = 1'b0;
  gauss3 = 1'b0;
  gauss4 = 1'b0;
  if(SW[8:6] == 3'b010)begin
    gauss1 = bll;
    gauss2 = bl;
    gauss3 = br;
    gauss4 = brr;
  end
  gauss_sel = {gauss1, gauss2, gauss3, gauss4};
 
  // color detect logic
  clr1 = 1'b0;
  clr2 = 1'b0;
  clr3 = 1'b0;
  clr4 = 1'b0;
  if(SW[8:6] == 3'b011)begin
    clr1 = bll;
    clr2 = bl;
    clr3 = br;
    clr4 = brr;
  end
  clr_sel = {clr1, clr2, clr3, clr4};
  
  // green screen bg logic
  bg1 = 1'b0;
  bg2 = 1'b0;
  bg3 = 1'b0;
  bg4 = 1'b0;
  if(SW[8:6] == 3'b100)begin
    bg1 = bll;
    bg2 = bl;
    bg3 = br;
    bg4 = brr;
  end
  gs_bg_sel = {bg1, bg2, bg3, bg4};

  // cursor logic
  move = 4'hF;
  mode = 2'b0;
  size1 = 1'b0;
  size2 = 1'b0;
  size3 = 1'b0;
  size4 = 1'b0;
  if(SW[8:6] == 3'b101)begin
    move = KEY;
  end
  if(SW[8:6] == 3'b110)begin
    mode[0] = br;
    mode[1] = brr;
  end
  if(SW[8:6] == 3'b111)begin
    size1 = bll;
    size2 = bl;
    size3 = br;
    size4 = brr;
  end
  size = {size1, size2, size3, size4};


	
end


always @(posedge clk) begin
  en <= #1 en_c;
end

endmodule
