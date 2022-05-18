module row_shift_en_gen (
	input [12:0] col,
	input [12:0] x_count,
	output reg en0,
	output reg en1,
	output reg en2,
	output reg en3,
	output reg en4,
	output reg en5,
	output reg en6,
	output reg en7,
	output reg en8,
	output reg en9,
	output reg en10
);

always @(*) begin
	en0 = 1'b0;
	en1 = 1'b0;
	en2 = 1'b0;
	en3 = 1'b0;
	en4 = 1'b0;
	en5 = 1'b0;
	en6 = 1'b0;
	en7 = 1'b0;
	en8 = 1'b0;
	en9 = 1'b0;
	en10 = 1'b0;

	/* C code for if needs range change
	for (int i = 0; i <= 10; i++)
    printf("\tif (col < 13'd0%i || x_count > 13'd0%i) begin\n\t\ten%i = 1'b1;\n\tend\n", 640-i, 799-i, i);
	 */	
	
	if (col < 13'd0636 || x_count > 13'd0164) begin
		en0 = 1'b1;
	end
	if ((col < 13'd0635 || col > 13'd8000) &&  x_count > 13'd0163) begin
		en1 = 1'b1;
	end
	if ((col < 13'd0634 || col > 13'd8000) &&  x_count > 13'd0162) begin
		en2 = 1'b1;
	end
	if ((col < 13'd0633 || col > 13'd8000) &&  x_count > 13'd0161) begin
		en3 = 1'b1;
	end
	if ((col < 13'd0632 || col > 13'd8000) &&  x_count > 13'd0160) begin
		en4 = 1'b1;
	end
	if ((col < 13'd0631 || col > 13'd8000) &&  x_count > 13'd0159) begin
		en5 = 1'b1;
	end
	if ((col < 13'd0630 || col > 13'd8000) &&  x_count > 13'd0158) begin
		en6 = 1'b1;
	end
	if ((col < 13'd0629 || col > 13'd8000) &&  x_count > 13'd0157) begin
		en7 = 1'b1;
	end
	if ((col < 13'd0628 || col > 13'd8000) &&  x_count > 13'd0156) begin
		en8 = 1'b1;
	end
	if ((col < 13'd0627 || col > 13'd8000) &&  x_count > 13'd0155) begin
		en9 = 1'b1;
	end
	if ( (col < 13'd0626 || col > 13'd8000) && x_count > 13'd0154) begin
		en10 = 1'b1;
	end

	
end

endmodule
