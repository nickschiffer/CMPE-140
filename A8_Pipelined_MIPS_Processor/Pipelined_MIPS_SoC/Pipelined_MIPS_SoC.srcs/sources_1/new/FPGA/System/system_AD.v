

module system_AD(
        input WE,
        input [31:0] A,
        output WEM,
        output WE1,
        output WE2,
        output reg [1:0] RdSel
    );
    
    assign WE1 = (A[31:30] == 2'b10 && A[28:26] == 3'b011 && A[15:8] == 8'H08 && A[15:0] < 16'H900 && WE) ? 1 : 0;
    assign WE2 = (A[31:30] == 2'b10 && A[28:26] == 3'b011 && A[15:8] == 8'H09 && WE) ? 1 : 0;
    assign WEM = (A[15:8] < 32'H800 && WE) ? 1 : 0;
    
    always @ (A) begin
        
        if (A[31:30] == 2'b10 && A[28:26] == 3'b011 && A[15:8] == 8'b00001000) RdSel <= 2'b10;
        else if (A[31:30] == 2'b10 && A[28:26] == 3'b011 && A[15:8] == 8'b00001001) RdSel <= 2'b11;   
        else RdSel <= 2'b00; 
    end
    
    
    
endmodule
