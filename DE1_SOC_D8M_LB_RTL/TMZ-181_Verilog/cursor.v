`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module cursor (
  input clk,
  input rst,
  input [12:0] row,
  input [12:0] col,
  input [3:0] move,
  input [3:0] size,
  input [1:0] mode,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out,
  input [23:0] pass_in
);

reg [23:0] pixel_out_c;

reg [12:0] vpos, hpos, vpos_c, hpos_c;
reg [12:0] cur_size, cur_size_c;
reg count, count_c;
reg cur_mode, cur_mode_c;


initial begin
  cur_size = 13'd0;
  count = 1'b0;
  cur_mode = 1'b0;
  hpos = 320;
  vpos = 240;
end

always @(*) begin
  
  //size select
  case (size)
    4'b0001: begin
	   cur_size_c = 13'd0;
	 end
	 4'b0010: begin
	   cur_size_c = 13'd320;
	 end
	 4'b0100: begin
	   cur_size_c = 13'd240;
	 end
	 4'b1000: begin
	   cur_size_c = 13'd120;
	 end
	 default: begin
	   cur_size_c = cur_size;
	 end
  endcase
  
  //mode select
  case (mode)
    4'b01: begin
	   cur_mode_c = 1'b0;
	 end
	 4'b10: begin
	   cur_mode_c = 1'b1;
	 end
	 default: begin
	   cur_mode_c = cur_mode;
	 end
  endcase
  
  //move logic
  count_c = count;
  hpos_c = hpos;
  vpos_c = vpos;
  if (row == 13'd0000 && col == 13'd0000) begin
    count_c = count + 1'b1;
    if (rst == 1'b1) begin
	   count_c = 1'b0;
    end
  end
  
  if (row == 13'd0000 && col == 13'd0000 && count == 1'b0) begin // per 2nd frame
    //up
	 if (move[1] == 1'b0 && vpos > 13'd0058) begin
	   vpos_c = vpos - 13'd0001;  
	 end
		 
	 //down1
	 if (move[2] == 1'b0 && vpos < (13'd0514 - cur_size)) begin
		vpos_c = vpos + 13'd0001;
	 end
		 
	 //left1
	 if (move[3] == 1'b0 && hpos > 13'd0200) begin
	   hpos_c = hpos - 13'd0001;
	 end
		 
	 //right1
	 if (move[0] == 1'b0 && hpos < (13'd0769 - cur_size)) begin
	   hpos_c = hpos + 13'd0001;  
    end
  end
  if (vpos > (13'd0514 - cur_size)) begin
    vpos_c = (13'd0514 - cur_size);
  end
  if (hpos > (13'd0769 - cur_size)) begin
    hpos_c = (13'd0769 - cur_size);
  end
  if (vpos < 13'd0058) begin
    vpos_c = 13'd0058;
  end
  if (hpos < 13'd0200) begin
    hpos_c = 13'd0200;
  end
  
  // Choose output logic
  pixel_out_c = pixel_in;
  if (cur_size != 13'd0) begin
    if ((row >= vpos) && (row <= (vpos + cur_size - 13'd0001)) && (col >= hpos) && (col <= (hpos + cur_size - 13'd0001))) begin //cursor border
      pixel_out_c = 24'b00_1111_000_111_1111_1111_1111;
    end
	 else begin
      if (cur_mode == 1'b1) begin
	     pixel_out_c = pass_in;
		end
		else begin
		  pixel_out_c = pixel_in;
		end
    end
  
    if ((row >= (vpos + 13'd0001)) && (row <= (vpos + cur_size - 13'd0002)) && (col >= (hpos + 13'd0001)) && (col <= (hpos + cur_size - 13'd0002))) begin
      if (cur_mode == 1'b1) begin
	     pixel_out_c = pixel_in;
		end
		else begin
		  pixel_out_c = pass_in;
		end
    end
  end
end


always @(posedge clk) begin
  vpos <= #1 vpos_c;
  hpos <= #1 hpos_c;
  cur_size <= #1 cur_size_c;
  cur_mode <= #1 cur_mode_c;
  count <= #1 count_c;
  pixel_out <= #1 pixel_out_c; 
end


endmodule
