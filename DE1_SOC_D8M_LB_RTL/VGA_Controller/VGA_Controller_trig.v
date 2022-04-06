

module VGA_Controller_trig(
    input     [12:0] col,
    input     [12:0] row,
    input		[7:0]	iRed,
    input		[7:0]	iGreen,
    input		[7:0]	iBlue,
    output		[7:0]	oVGA_R,
    output		[7:0]	oVGA_G,
    output		[7:0]	oVGA_B,
    output				oVGA_H_SYNC,
    output				oVGA_V_SYNC,
    output				oVGA_SYNC,
    output				oVGA_BLANK,
	 output           orequest , 
    //	Control Signal
    input				   iCLK,
    input				   iRST_N,
    output              oVGA_CLOCK

);

`include "VGA_Param.h"
//=============================================================================
// REG/WIRE declarations
//=============================================================================
wire		[7:0]	mVGA_R;
wire		[7:0]	mVGA_G;
wire		[7:0]	mVGA_B;
wire				mVGA_H_SYNC;
wire				mVGA_V_SYNC;
wire				mVGA_SYNC;
wire				mVGA_BLANK;
//=======================================================
assign oVGA_SYNC = 1'b0;
		
assign oVGA_CLOCK = iCLK ; 

assign orequest = ((col > H_BLANK  && col<H_SYNC_TOTAL  ) &&
						 ( row> V_BLANK  && row<V_SYNC_TOTAL));

assign oVGA_BLANK	=	~((col < H_BLANK ) || ( row < V_BLANK ));

assign oVGA_R = iRed;
assign oVGA_G = iGreen;
assign oVGA_B = iBlue;

assign oVGA_H_SYNC =	(( col > (H_SYNC_FRONT ))  &&  (col <= (H_SYNC_CYC + H_SYNC_FRONT)))?0 :1 ; 
assign oVGA_V_SYNC =	(( row > (V_SYNC_FRONT ))  &&  (row <= (V_SYNC_CYC + V_SYNC_FRONT)))?0 :1 ; 

endmodule
