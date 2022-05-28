
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

rgb_hsv h0 (raw_VGA_R, raw_VGA_G, raw_VGA_B, pixel0);
hsv_rgb r0 (pixel11, VGA_R, VGA_G, VGA_B);

wire [23:0] pass0, pass1, pass2, pass3, pass4, pass5, pass6, pass7, pass8, pass9;
wire [23:0] pixel0, pixel1, pixel2, pixel3, pixel4, pixel5, pixel6, pixel7, pixel8, pixel9, pixel10, pixel11;
assign pass0 = pixel0;

wire [7:0] cartoon_edge;
wire [23:0] cartoon_blur;
wire rst = SW[9];
wire clk = MIPI_PIXEL_CLK_;
wire binc, bdec, cinc, cdec, sinc, sdec;
wire [3:0] en, clr_sel, gs_bg_sel, gauss_sel, edge_gauss_sel, move, size;
wire [1:0] mode;
wire [3:0] level_out;

control ctrl(
.clk(clk),
.rst(rst),
.SW(SW[9:0]),
.KEY(KEY[3:0]),
.en(en),
.binc(binc),
.bdec(bdec),
.cinc(cinc),
.cdec(cdec),
.sinc(sinc),
.sdec(sdec),
.clr_sel(clr_sel),
.gs_bg_sel(gs_bg_sel),
.gauss_sel(gauss_sel),
.edge_gauss_sel(edge_gauss_sel),
.move(move),
.size(size),
.mode(mode)
);

edge_detect edge_det0 (
.clk(clk),
.rst(rst),
.col(col),
.x_count(x_count),
.filt_sel(edge_gauss_sel),
.en(en[2]),
.cartoon_edge(cartoon_edge),
.cartoon_blur(cartoon_blur),
.pixel_in(pixel0),
.pixel_out(pixel1),
.pass_in(pass0),
.pass_thru(pass1)
);


cartoon cartoon1(
.clk(clk),
.cartoon_edge(cartoon_edge),
.cartoon_blur(cartoon_blur),
.en(en[1]),
.pixel_in(pixel1),
.pixel_out(pixel2),
.pass_in(pass1),
.pass_thru(pass2)
);

colordetc colodetc1(
.clk(clk),
.rst(rst),
.clr_sel(clr_sel),
.pixel_in(pixel2),
.pixel_out(pixel3),
.pass_in(pass2),
.pass_thru(pass3)
);

greensc greensc1(
.clk(clk),
.row(row),
.col(col),
.gsc_en(en[0]),
.gs_bg_sel(gs_bg_sel),
.pixel_in(pixel3),
.pixel_out(pixel4),
.pass_in(pass3),
.pass_thru(pass4)
);

blur gs2(
.clk(clk),
.rst(rst),
.col(col),
.x_count(x_count),
.filt_sel(gauss_sel),
.pixel_in(pixel4),
.pixel_out(pixel5),
.pass_in(pass4),
.pass_thru(pass5)
);

grayscale grayscale1(
.clk(clk),
.rst(rst),
.en(en[3]),
.pixel_in(pixel5),
.pixel_out(pixel6),
.pass_in(pass5),
.pass_thru(pass6)
);

brightness brightness1(
.clk(clk),
.rst(rst),
.inc(binc),
.dec(bdec),
.pixel_in(pixel6),
.pixel_out(pixel7),
.pass_in(pass6),
.pass_thru(pass7),
.level_out(level_out)
);

contrast contrast1(
.clk(clk),
.rst(rst),
.inc(cinc),
.dec(cdec),
.pixel_in(pixel7),
.pixel_out(pixel8),
.pass_in(pass7),
.pass_thru(pass8),
.level_out(level_out)
);

saturation saturation1(
.clk(clk),
.rst(rst),
.inc(sinc),
.dec(sdec),
.pixel_in(pixel8),
.pixel_out(pixel9),
.pass_in(pass8),
.pass_thru(pass9),
.level_out(level_out)
);

cursor cursor1(
.clk(clk),
.rst(rst),
.row(y_count),
.col(x_count),
.move(move),
.size(size),
.mode(mode),
.pixel_in(pixel9),
.pixel_out(pixel10),
.pass_in(pass9)
);

border border1(
.clk(clk),
.rst(rst),
.row(y_count),
.col(x_count),
.bg_sel(SW[2:1]),
.pixel_in(pixel10),
.pixel_out(pixel11)
);

endmodule
