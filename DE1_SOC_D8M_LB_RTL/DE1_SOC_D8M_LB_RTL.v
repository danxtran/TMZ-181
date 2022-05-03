
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

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
wire [7:0] VGA_R_OUT, VGA_G_OUT, VGA_B_OUT;
assign VGA_R = VGA_R_OUT;
assign VGA_G = VGA_G_OUT;
assign VGA_B = VGA_B_OUT;

wire [31:0] enable;
wire [5119:0] raw_r_buf, raw_g_buf, raw_b_buf, shift_g, shift_b;

wire [5119:0] shift_r_11, shift_r_10, shift_r_9, shift_r_8, shift_r_7; 
wire [5119:0] shift_g_11, shift_g_10, shift_g_9, shift_g_8, shift_g_7; 
wire [5119:0] shift_b_11, shift_b_10, shift_b_9, shift_b_8, shift_b_7; 

control ctrl(.clk(MIPI_PIXEL_CLK_), .en(enable), .row(row), .col(col), .x_count(x_count), .y_count(y_count),.rst());

gauss gauss_filter_r(.clk(MIPI_PIXEL_CLK_), .r(raw_VGA_R), .g(raw_VGA_G), .b(raw_VGA_B), .col(col), .buff_en(enable[1]),
							.shift_en(enable[2]), .en_gauss5x5(enable[3]),.out_r(VGA_R_OUT), .out_g(VGA_G_OUT), .out_b(VGA_B_OUT));
assign LEDR[2] = SW[2] ? 1'b1 : 1'b0;
//gauss gauss_filter_g(.clk(MIPI_PIXEL_CLK_), .row_pixel1(shift_g_7), .row_pixel2(shift_g_8), .row_pixel3(shift_g_9)
//, .row_pixel4(shift_g_10), .row_pixel5(shift_g_11), .col(col),.out_pixel(VGA_G_OUT));
//
//gauss gauss_filter_b(.clk(MIPI_PIXEL_CLK_), .row_pixel1(shift_b_7), .row_pixel2(shift_b_8), .row_pixel3(shift_b_9)
//, .row_pixel4(shift_b_10), .row_pixel5(shift_b_11), .col(col),.out_pixel(VGA_B_OUT));



endmodule
