
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================
`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module DE1_SOC_D8M_LB_RTL(

	//////////// CLOCK //////////
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

	//////////// GPIO_1, GPIO_1 connect to D8M-GPIO //////////
	inout 		          		CAMERA_I2C_SCL,
	inout 		          		CAMERA_I2C_SDA,
	output		          		CAMERA_PWDN_n,
	output		          		MIPI_CS_n,
	inout 		          		MIPI_I2C_SCL,
	inout 		          		MIPI_I2C_SDA,
	output		          		MIPI_MCLK,
	input 		          		MIPI_PIXEL_CLK,
	input 		     [9:0]		MIPI_PIXEL_D,
	input 		          		MIPI_PIXEL_HS,
	input 		          		MIPI_PIXEL_VS,
	output		          		MIPI_REFCLK,
	output		          		MIPI_RESET_n
);

//=============================================================================
// REG/WIRE declarations
//=============================================================================
   wire       orequest;
   wire 	[7:0]raw_VGA_R;
   wire 	[7:0]raw_VGA_G;
   wire 	 [7:0]raw_VGA_B;
   wire        VGA_CLK_25M;
   wire        RESET_N; 
   wire   [7:0]sCCD_R;
   wire   [7:0]sCCD_G;
   wire   [7:0]sCCD_B; 
   wire  [12:0]x_count,col; 
   wire  [12:0]y_count,row; 
   wire        I2C_RELEASE ;  
   wire        CAMERA_I2C_SCL_MIPI; 
   wire        CAMERA_I2C_SCL_AF;
   wire        CAMERA_MIPI_RELAESE;
   wire        MIPI_BRIDGE_RELEASE;
   wire        RESET_SW; 
  
   wire        LUT_MIPI_PIXEL_HS;
   wire        LUT_MIPI_PIXEL_VS;
   wire [9:0]  LUT_MIPI_PIXEL_D;
   wire        MIPI_PIXEL_CLK_; 
//=======================================================
// Structural coding
//=======================================================

assign  MIPI_PIXEL_CLK_   = MIPI_PIXEL_CLK;
assign  LUT_MIPI_PIXEL_HS = MIPI_PIXEL_HS;
assign  LUT_MIPI_PIXEL_VS = MIPI_PIXEL_VS;
assign  LUT_MIPI_PIXEL_D  = MIPI_PIXEL_D ;

assign RESET_SW= ~SW[0]; 

//----- RESET RELAY  --		
RESET_DELAY			u2	(	
	.iRST  ( RESET_SW ),
   .iCLK  ( CLOCK_50 ),				
	.oREADY( RESET_N ) 			
);

assign MIPI_RESET_n   = RESET_N;
assign CAMERA_PWDN_n  = RESET_SW; 
assign MIPI_CS_n      = 0; 

//------ CAMERA I2C COM BUS --------------------
//assign I2C_RELEASE    = CAMERA_MIPI_RELAESE & MIPI_BRIDGE_RELEASE; 
assign CAMERA_I2C_SCL = CAMERA_I2C_SCL_MIPI ;   
 
//------ MIPI BRIDGE  I2C SETTING--------------- shift_r
MIPI_BRIDGE_CAMERA_Config    cfin(
   .RESET_N           ( RESET_N  ), 
   .CLK_50            ( CLOCK_50), 
   .MIPI_I2C_SCL      ( MIPI_I2C_SCL ), 
   .MIPI_I2C_SDA      ( MIPI_I2C_SDA ), 
   .MIPI_I2C_RELEASE  ( MIPI_BRIDGE_RELEASE ),  
   .CAMERA_I2C_SCL    ( CAMERA_I2C_SCL_MIPI ),
   .CAMERA_I2C_SDA    ( CAMERA_I2C_SDA ),
   .CAMERA_I2C_RELAESE( CAMERA_MIPI_RELAESE )
);
 
//-- Video PLL --- 
pll_test ref(
	.refclk   ( CLOCK_50  ),   
	.rst      ( 1'b0 ),     
	.outclk_0 ( MIPI_REFCLK )//20m
	);

//--- D8M RAWDATA to RGB ---
D8M_SET   ccd (
	.RESET_SYS_N  ( RESET_N  ),
   .CLOCK_50     ( CLOCK_50 ),
	.CCD_DATA     ( LUT_MIPI_PIXEL_D [9:0]) ,
	.CCD_FVAL     ( LUT_MIPI_PIXEL_VS ), //60HZ
	.CCD_LVAL	  ( LUT_MIPI_PIXEL_HS ), // 
	.CCD_PIXCLK   ( MIPI_PIXEL_CLK_), //25MHZ
	.READ_EN      (orequest) , 	
   .VGA_HS       ( VGA_HS ),
   .VGA_VS       ( VGA_VS ),
	.X_Cont          ( x_count),  
   .Y_Cont          ( y_count),   
   .sCCD_R       ( raw_VGA_R ),
   .sCCD_G       ( raw_VGA_G ),
   .sCCD_B       ( raw_VGA_B )
);



//---  VGA  --  
assign VGA_CLK = MIPI_PIXEL_CLK_;//GPIO clk
assign VGA_SYNC_N = 1'b0;
		
assign orequest = ((x_count > 160 && x_count < 800  ) &&
	            ( y_count> 45  && y_count < 525)); // output is required

assign VGA_BLANK_N	=	~((x_count < 160 ) || ( y_count < 45 ));//active low, VGA blank 

assign VGA_HS =	(( x_count > 16 )  &&  (x_count <= 97))?0 :1 ; 
assign VGA_VS =	(( y_count > 10)  &&  (y_count <= 12))?0 :1 ; 
assign col = x_count - 164;
assign row = y_count - 47;

// OUR CODE
wire [23:0] HSV;
rgb_hsv h0 (raw_VGA_R, raw_VGA_G, raw_VGA_B, HSV);
hsv_rgb r0 (HSV, VGA_R, VGA_G, VGA_B);

//wire [23:0] pass0, pass1, pass2, pass3, pass4, pass5, pass6, pass7, pass8;
//wire [7:0] out_r0, out_r1, out_r2, out_r3, out_r4, out_r5, out_r6, out_r7, out_r8;
//wire [7:0] out_g0, out_g1, out_g2, out_g3, out_g4, out_g5, out_g6, out_g7, out_g8;
//wire [7:0] out_b0, out_b1, out_b2, out_b3, out_b4, out_b5, out_b6, out_b7, out_b8;
//wire [7:0] cartoon_edge;
//wire [23:0] cartoon_blur;
//wire rst = SW[9];
//wire clk = MIPI_PIXEL_CLK_;
//wire [31:0] en;
//wire binc, bdec, cinc, cdec;
//wire [3:0] clr_sel, gauss_sel, edge_gauss_sel;
//wire [3:0] level_out;
//control ctrl(
//.clk(clk),
//.rst(rst),
//.SW(SW[9:0]),
//.KEY(KEY[3:0]),
//.row(row),
//.col(col),
//.x_count(x_count),
//.y_count(y_count),
//.en(en),
//.binc(binc),
//.bdec(bdec),
//.cinc(cinc),
//.cdec(cdec),
//.clr_sel(clr_sel),
//.gauss_sel(gauss_sel),
//.edge_gauss_sel(edge_gauss_sel)
//);
//
//gauss gs1(
//.clk(clk),
//.rst(rst),
//.r(raw_VGA_R),
//.g(raw_VGA_G),
//.b(raw_VGA_B),
//.col(col),
//.x_count(x_count),
//.filt_sel(edge_gauss_sel),
//.outR(out_r0),
//.outG(out_g0),
//.outB(out_b0),
//.pass_in({raw_VGA_R, raw_VGA_G, raw_VGA_B}),
//.pass_thru(pass0)
//);
//
//sobel_edge_det sed(
//.clk(clk),
//.r(out_r0),
//.g(out_g0),
//.b(out_b0),
//.col(col),
//.x_count(x_count),
//.en(en[5]),
//.cartoon_edge(cartoon_edge),
//.cartoon_blur(cartoon_blur),
//.outR(out_r1),
//.outG(out_g1),
//.outB(out_b1),
//.pass_in(pass0),
//.pass_thru(pass1)
//);
//
//cartoon cartoon1(
//.r(out_r1),
//.g(out_g1),
//.b(out_b1),
//.cartoon_edge(cartoon_edge),
//.cartoon_blur(cartoon_blur),
//.en(en[2]),
//.outR(out_r2),
//.outG(out_g2),
//.outB(out_b2),
//.pass_in(pass1),
//.pass_thru(pass2)
//);
//
//colordetc colodetc1(
//.clk(clk),
//.rst(rst),
//.r(out_r2),
//.g(out_g2),
//.b(out_b2),
//.clr_sel(clr_sel),
//.outR(out_r3),
//.outG(out_g3),
//.outB(out_b3),
//.pass_in(pass2),
//.pass_thru(pass3)
//);
//
//greensc greensc1(
//.r(out_r3),
//.g(out_g3),
//.b(out_b3),
//.gsc_en(en[4]),
//.outR(out_r4),
//.outG(out_g4),
//.outB(out_b4),
//.pass_in(pass3),
//.pass_thru(pass4)
//);
//
//gauss gs2(
//.clk(clk),
//.rst(rst),
//.r(out_r4),
//.g(out_g4),
//.b(out_b4),
//.col(col),
//.x_count(x_count),
//.filt_sel(gauss_sel),
//.outR(out_r5),
//.outG(out_g5),
//.outB(out_b5),
//.pass_in(pass4),
//.pass_thru(pass5)
//);
//
//grayscale grayscale1(
//.clk(clk),
//.rst(rst),
//.en(en[3]),
//.r(out_r5),
//.g(out_g5),
//.b(out_b5),
//.outR(out_r6),
//.outG(out_g6),
//.outB(out_b6),
//.pass_in(pass5),
//.pass_thru(pass6)
//);
//
//brightness brightness1(
//.clk(clk),
//.rst(rst),
//.inc(binc),
//.dec(bdec),
//.r(out_r6),
//.g(out_g6),
//.b(out_b6),
//.outR(out_r7),
//.outG(out_g7),
//.outB(out_b7),
//.pass_in(pass6),
//.pass_thru(pass7),
//.level_out(level_out)
//);
//
//contrast contrast1(
//.clk(clk),
//.rst(rst),
//.inc(cinc),
//.dec(cdec),
//.r(out_r7),
//.g(out_g7),
//.b(out_b7),
//.outR(out_r8),
//.outG(out_g8),
//.outB(out_b8),
//.pass_in(pass7),
//.pass_thru(pass8),
//.level_out(level_out)
//);
//
//cursor cursor1(
//.col(col),
//.r(out_r8),
//.g(out_g8),
//.b(out_b8),
//.outR(VGA_R),
//.outG(VGA_G),
//.outB(VGA_B),
//.pass_in(pass8),
//);

endmodule
