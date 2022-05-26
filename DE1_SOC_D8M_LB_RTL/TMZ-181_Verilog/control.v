`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module control ( // control module
  input clk,
  input rst,
  input [9:0] SW,
  input [3:0] KEY,
  input [12:0] row,
  input [12:0] col,
  input [12:0] x_count,
  input [12:0] y_count,
  output reg [31:0]  en, // enable signals ******UPDATE BIT SIZE WHEN FINISHED*****
  
  //brightness signals
  output reg binc, // increase brightness signal
  output reg bdec, // decrease brightness signal
  
  //contrast signals
  output reg cinc, // increase contrast signal
  output reg cdec, // decrease contrast signal
  //color select signal
  output reg [3:0] clr_sel,
  //gauss select signal
  output reg [3:0] gauss_sel,
  //edge detect signals
  output reg [3:0] edge_gauss_sel
);
/* enable signal bits
0 - brightness
1 - N/A
2 - cartoon effect
3 - gray scale
4 - green screen
5 - edge detect
*/
/* Module Switch Usage
0 - RST
1 - brightness
2 - blur
3 - grayscale
4 - cursor
5 - color detect
6 - green screen
7- cartoon
8 - edge detect
9 - N/A
*/

// master logic vars & modules
parameter rowMax = 13'd0480;
parameter colMax = 13'd0640;
reg frame_en_c;
reg [30:0] en_c;
//brightness vars & modules
wire incb, decb;
lvl2pulse INCb (clk, KEY[0], incb);
lvl2pulse DECb (clk, KEY[1], decb);
//contrast vars & modules
wire incc, decc;
lvl2pulse INCc (clk, KEY[2], incc);
lvl2pulse DECc (clk, KEY[3], decc);
//color detect vars & modules
reg clr1, clr2, clr3, clr4;
//gauss vars & modules
reg gauss1, gauss2, gauss3, gauss4;

always @(*) begin

	//enable signals default
	en_c = 31'b0;

  //brightness & contrast logic
  binc = 1'b0;
  bdec = 1'b0;
  cinc = 1'b0;
  cdec = 1'b0;
  if (SW[1] == 1'b1) begin
    binc = incb;
	 bdec = decb;
	 cinc = incc;
	 cdec = decc;
	 en_c[0] = 1'b1;
  end
  
	// grayscale on
	if(SW[3] == 1'b1)begin
		en_c[3] = 1'b1;
	end else begin
		en_c[3] = 1'b0;
	end
	// green screen on
	if(SW[6] == 1'b1)begin
		en_c[4] = 1'b1;
	end else begin
		en_c[4] = 1'b0;
	end
	
    // gauss en
    gauss1 = 1'b0;
    gauss2 = 1'b0;
    gauss3 = 1'b0;
    gauss4 = 1'b0;
    if(SW[2] == 1'b1)begin
        gauss1 = incb;
        gauss2 = decb;
        gauss3 = incc;
        gauss4 = decc;
    end
	 
	 gauss_sel = {gauss4, gauss3, gauss2, gauss1};

	 
	// color detect on
	clr1 = 1'b0;
	clr2 = 1'b0;
	clr3 = 1'b0;
	clr4 = 1'b0;
	
	if(SW[5] == 1'b1)begin
		 clr1 = incb;
		 clr2 = decb;
		 clr3 = incc;
		 clr4 = decc;
	end
	
	clr_sel = {clr4, clr3, clr2, clr1};
	
	//edge detect on
	edge_gauss_sel = 4'h1;
	if(SW[8] == 1'b1)begin
	  en_c[5] = 1'b1;
	end
	//cartoon on
	if(SW[7] == 1'b1)begin
	  edge_gauss_sel = 4'h2;
	  en_c[5] = 1'b1;
	  en_c[2] = 1'b1;
	end
	
end


always @(posedge clk) begin
  en <= #1 en_c;
end

endmodule
