module border (
  input clk,
  input rst,
  input [12:0] row,
  input [12:0] col,
  input [3:0] bg_sel,
  input [23:0] pixel_in,
  output reg [23:0] pixel_out
);

reg [23:0] pixel_out_c;
reg [8:0] count, count_c;
reg [15:0] slow_count, slow_count_c;

wire [13:0] sum0 = row + col + count - 10'd222;
wire [13:0] sum1 = row - col + 10'd760 + count;
wire [13:0] sum2 = row + count;
wire [13:0] sum3 = col + count;
wire [8:0] bg0, bg1, bg2, bg3;

mod360 mbg0 (sum0[10:0], bg0);
mod360 mbg1 (sum1[10:0], bg1);
mod360 mbg2 (sum2[10:0], bg2);
mod360 mbg3 (sum3[10:0], bg3);

initial begin
  count = 9'd0;
  slow_count = 9'b0;
end

always @(*) begin
  count_c = count;
  slow_count_c = slow_count + 9'd1;
  pixel_out_c = pixel_in;
  
  if (slow_count == 9'd0) begin
    count_c = count + 9'd1;
  end

  if ((row <= 13'd57 || row >= 13'd514) || (col <= 13'd200 || col >= 13'd770)) begin
    case (bg_sel)
      2'b01: begin
        pixel_out_c = {bg1, 15'b111_1111_1111_1111};
      end
	   2'b10: begin
		  pixel_out_c = {bg2, 15'b111_1111_1111_1111};
	   end
      2'b11: begin
        pixel_out_c = {bg3, 15'b111_1111_1111_1111};
      end
      default: begin
        pixel_out_c = {bg0, 15'b111_1111_1111_1111};
      end
    endcase
  end
  
  if (count_c > 9'd360) begin
    count_c = 9'd0;
  end
  
  if (rst == 1'b1) begin
    count_c = 9'd0;
	 slow_count_c = 9'd0;
  end
  
  
end

always @(posedge clk) begin
  count <= #1 count_c;
  slow_count <= #1 slow_count_c;
  pixel_out <= #1 pixel_out_c; 
end

endmodule
