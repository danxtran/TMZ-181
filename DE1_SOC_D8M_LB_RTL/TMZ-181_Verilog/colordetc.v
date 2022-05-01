module colordetc (
  input [1:0] ctrl,
  input [7:0] in_r,
  input [7:0] in_g,
  input [7:0] in_b,
  
  output [7:0] out_r,
  output [7:0] out_g,
  output [7:0] out_b
);

  wire signed [24:0] greeness;
  wire signed [24:0] redness;
  wire signed [24:0] bluewness;
  wire signed [24:0] thresh;
  reg [7:0] out_reg_r, out_reg_g, out_reg_b, shift_r, shift_g, shift_b;

  assign redness = in_r*(in_r-in_g)*(in_r-in_b);
  assign greeness = in_g*(in_g-in_r)*(in_g-in_b);
  assign blueness = in_b*(in_b-in_r)*(in_b-in_g);
  assign thresh = 25'b0_0000_0001_0100_0011_1101_1010;
 
  assign out_r = out_reg_r;
  assign out_g = out_reg_g;
  assign out_b = out_reg_b;
  
  always @(*) begin
    if (in_r[7:6] == 2'b00) begin
      shift_r = {in_r[5:0],2'b00};
    end
    else begin
      shift_r = 8'b1111_1111;
    end
    if (in_g[7:6] == 2'b00) begin
      shift_g = {in_g[5:0],2'b00};
    end
    else begin
      shift_g = 8'b1111_1111;
    end
    if (in_b[7:6] == 2'b00) begin
      shift_b = {in_b[5:0],2'b00};
    end
    else begin
      shift_b = 8'b1111_1111;
    end
     
    case (ctrl)
      2'b00: begin //highlight r
        out_reg_r = ((redness > thresh)) ? (shift_r) : in_r;
        out_reg_g = ((redness > thresh)) ? (shift_g) : in_g;
        out_reg_b = ((redness > thresh)) ? (shift_b) : in_b;
      end
      2'b01: begin //highlight g
        out_reg_r = ((greeness > thresh)) ? (shift_r) : in_r;
        out_reg_g = ((greeness > thresh)) ? (shift_g) : in_g;
        out_reg_b = ((greeness > thresh)) ? (shift_b) : in_b;
      end
      2'b10: begin //highlight b
        out_reg_r = ((blueness > thresh)) ? (shift_r) : in_r;
        out_reg_g = ((blueness > thresh)) ? (shift_g) : in_g;
        out_reg_b = ((blueness > thresh)) ? (shift_b) : in_b;
      end
    endcase
  end
  
endmodule
