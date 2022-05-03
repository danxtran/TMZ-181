module fifo(
  input clk,
  input rst,
  input wr_en,
  input rd_en,
  input [7:0] data_in,
  
  output full,
  output empty,
  output reg [7:0] data_o
);
  
  reg [7:0] mem [0:639];
  reg [9:0] wr_ptr; //work on bit num
  reg [9:0] rd_ptr;
  reg [9:0] count;
  
  assign full = (count == 640);
  assign empty = (count == 0);
  
  always @(posedge clk or rst) begin
    if(reset) begin
      
    end
    else begin
      
      
    end
  
  
  
endmodule
  
