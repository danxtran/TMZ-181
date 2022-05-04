module key_up_down (
    input clk,
    input key,
    input reset,
    
    output pressed
);
    reg pressed;
    reg k1_count, k1_count_c;
    

    always @(posedge clk) begin
        
        k1_count <= #1 k1_count_c;
        
    end
    
    always @(*) begin
        if(reset) begin
            k1_count_c = 2'b00;
            pressed = 1'b0;
        end
        
        k1_count_c = 2'b00;
        pressed = 1'b0;
        if (k1_count == 2'b00) begin
            if (key==1'b0) begin
                k1_count_c = 2'b00;
                pressed = 1'b0;
            end
            else begin
                k1_count_c = 2'b01;
                pressed = 1'b0;
            end
        end
        else if (k1_count == 2'b01) begin
            if (key==1'b1) begin
                k1_count_c = 2'b01;
                pressed = 1'b0;
            end
            else begin
                k1_count_c = 2'b10;
                pressed = 1'b0;
            end
        end
        else if (k1_count == 2'b10) begin
            if (key==1'b1) begin
                k1_count_c = 2'b00;
                pressed = 1'b1;
            end
            else begin
                k1_count_c = 2'b00;
                pressed = 1'b0;
            end
        end
        
    end
    
endmodule


module brightness (
    input [7:0] R,
    input [7:0] G,
    input [7:0] B,
    input [1:0] ctrl,
    input reset,
    inout clk,
    
    output [7:0] ro,
    output [7:0] go,
    output [7:0] bo
);

    reg [3:0] count,count_c;
    reg [11:0] reg_r,reg_g,reg_b; //000xxxxxxxx000 - 000000xxxxxxxx
    reg [7:0] ror,rob,rog;

    
    
    
    initial begin 
        count_c = 4'b1000;
        count = 4'b1000;
    end
    wire up,down;
    
    key_up_down kuo (.clk(clk),.key(ctrl[1]),.reset(reset),.pressed(up));
    key_up_down kdw (.clk(clk),.key(ctrl[1]),.reset(reset),.pressed(down));
    
    always @(posedge clk) begin
        count <= #1 count_c;
    end
    
    always @(*) begin
        count_c = count;
        if (reset) begin
            count_c = 4'b1000;
        end
        if (count != 4'b1111) begin
            if(up) begin
                count_c = count +1'b1;
            end
        end
        if (count != 4'b0000) begin
            if(down) begin
                count_c = count - 1'b1;
            end
        end
        
        
        reg_r = {6'b000000,R}*count;
        reg_g = {6'b000000,G}*count;
        reg_b = {6'b000000,B}*count;
        
        if (reg_r[11]) begin
           ror = 8'b11111111 ;
        end
        else begin
            ror = reg_r[10:3] ;
        end
        
        if (reg_g[11]) begin
           rog = 8'b11111111 ;
        end
        else begin
            rog = reg_g[10:3] ;
        end
        
        if (reg_r[11]) begin
           rob = 8'b11111111 ;
        end
        else begin
            rob = reg_b[10:3] ;
        end
    end
    
    assign ro = ror;
    assign go = rog;
    assign bo = rob;
    

endmodule
