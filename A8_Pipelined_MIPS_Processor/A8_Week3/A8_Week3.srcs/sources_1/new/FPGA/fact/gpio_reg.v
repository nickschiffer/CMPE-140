module fact_reg#(parameter WIDTH=32)(
    input wire  Clk, Rst,
    input wire  [WIDTH -1:0] D,
    input wire  Load_Reg,
    output reg  [WIDTH -1:0] Q);
    
    always @ (posedge Clk, posedge Rst)
    begin
        if(Rst) Q <= 0;
        else if (Load_Reg) Q <= D;
        else Q <= Q;
    end

endmodule

