module CNT#(parameter DATA_WIDTH = 32)(
    input wire [DATA_WIDTH - 1:0] in,    
    input wire load_cnt, 
    input wire en, 
    input wire clk, 
    output reg [DATA_WIDTH -1:0] out);
    

    
    always@(posedge clk) begin
    	if(load_cnt) begin
        	out = in;
    	end 
    	if(en) begin
        	out = out - 1'b1;        
    	end
	end
endmodule

