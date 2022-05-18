module contrast_tb;
   reg enable; // master enable
	reg clock;
	reg reset;
	reg inc; // increase contrast signal
	reg dec; // decrease contrast signal
	reg [7:0] R;
	reg [7:0] G;
	reg [7:0] B;
	wire [7:0] outR;
	wire [7:0] outG;
	wire [7:0] outB;
	wire cdec, cinc;
	// control ctrl(.SW(SW), .KEY(KEY), .en(en), .cinc(cinc), .cdec(cdec), .clk(clock));
	// contrast UUT(.clk(clock), .enable(enable), .frame_en(frame_en), .rst(reset), .inc(cinc), .dec(cdec), .R(R), .G(G), .B(B), .outR(outR),
	//					.outG(outG), .outB(outB));
//	initial begin
//		reset = 1'b1; // assert reset
//		enable = 1'b0;
//		frame_en = 1'b0;
//		#100; // perhaps a few cycles
//		reset = 1'b0; // de-assert reset
//		#100;
//		R = 8'hDC;
//		G = 8'hCD;
//		B = 8'hEE;
//		enable = 1'b1;
//		SW = 10'b00000_00010;
//		#100;
//		KEY = 4'b0001;
//		frame_en = 1'b1;
//		#100;
//		KEY = 4'b0000;
//
//		#100;
//		KEY = 4'b0001;
//		#100;
//		KEY = 4'b0000;
//		#100;
//		KEY = 4'b0001;
//
//		#100;
//		KEY = 4'b0001;
//		#100
//		enable = 1'b1;
//
//		#100;
//		$finish; // stop simulation
//	end
	always begin
		if (reset == 1'b1) begin
			clock = 1'b0;
			#10; // let time advance when reset == 1'b1
			end
		else begin
			#100; // cycle time = #200
			clock = ~clock; // invert clock
		end
	end
endmodule
