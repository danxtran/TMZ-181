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
  output reg frame_en,
  
  //brightness signals
  output reg binc, // increase brightness signal
  output reg bdec, // decrease brightness signal
  
  //contrast signals
  output reg cinc, // increase contrast signal
  output reg cdec, // decrease contrast signal
  //color select signal
  output reg [3:0] clr_sel
);
/* enable signal bits
0 - brightness
1 - wr_en buffer
2 - shift_en shift reg
3 - gray scale
4 - green screen
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
// ROMs
// rom11x11 rom1(.clk(clk), .rd_en(), .addr(), .data_out());
// rom5x5 rom2(.clk(clk), .rd_en(), .addr(), .data_out());

reg [12:0] x_boundary;
always @(*) begin
  //master logic
  frame_en_c = 1'b0; // frame enable logic - enables once when switching to new frame
  if (row == rowMax && col == colMax) begin
    frame_en_c = 1'b1;
  end

  //brightness & contrast logic
  binc = 1'b0;
  bdec = 1'b0;
  cinc = 1'b0;
  cdec = 1'b0;
  en_c = 31'b0;
  if (SW[1] == 1'b1) begin
    binc = incb;
	 bdec = decb;
	 cinc = incc;
	 cdec = decc;
	 en_c[0] = 1'b1;
  end
  
  // write en buffer
  if (col < 13'd640) begin
		en_c[1] = 1'b1;
	end
	else begin
		en_c[1] = 1'b0;
	end
	// shift en 

	if (x_count == (13'd781) && y_count < (13'd528)) begin
		en_c[2] = 1'b1;
	end
	else begin
		en_c[2] = 1'b0;
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
//	if(SW[2] == 1'b1)begin
//		en_c[3] = 1'b1;
//	end else begin
//		en_c[3] = 1'b0;
//	end
	// color detect on
	if(SW[5] == 1'b1)begin
		if(KEY[0] == 1'b1)begin
			clr_sel[3:0] = 4'b0001;

		end 
		if (KEY[1] == 1'b1) begin
			clr_sel[3:0] = 4'b0010;

		end 
		if (KEY[2] == 1'b1) begin
			clr_sel[3:0] = 4'b0100;

		end 
		if (KEY[3] == 1'b1) begin
			clr_sel[3:0] = 4'b1000;

		end else begin
			clr_sel[3:0] = 4'b0000;

		end
	end else begin
		clr_sel[3:0] = 4'b0;

	end
	
end


always @(posedge clk) begin
  frame_en <= #1 frame_en_c;
  en <= #1 en_c;
end

endmodule
