`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2019 06:22:54 PM
// Design Name: 
// Module Name: Factorial_Top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Factorial_Top_tb;


reg Go_tb, clk_tb;
reg [3:0] n_tb;
wire Done_tb, Err_tb;
wire [31:0] nf_tb;
reg [31:0] nf_inf;

Factorial_Top DUT (
    .n(n_tb),
    .Go(Go_tb),
    .clk(clk_tb),
    .Done(Done_tb),
    .Err(Err_tb),
    .nf(nf_tb)
);


task automatic tick;
    begin
        clk_tb <= 1'b0;
        #50;
        clk_tb <= 1'b1;
        #50;
    end
endtask

function automatic [31:0] factorial;
    input [3:0]n;
    reg [31:0]nl, nf;
    begin
    nl = n;
    nf = 1;
    while (nl > 1)
    begin
        nf = nf * nl;
        nl = nl - 1;
    end
    factorial = nf;
    end
endfunction

initial
begin
    $display("Factorial Top Test Begin");
    clk_tb = 0;
    n_tb = 4'd1;
    tick;
    while (n_tb < 15)
    begin  
        Go_tb  = 1;
        clk_tb = 0;
        tick;
        while (!(Done_tb || Err_tb))
        begin
            tick;
        end
        if (Done_tb)
        begin
            $display("%0d!     = %0d",n_tb, nf_tb);
            nf_inf = factorial(n_tb);
            $display("%0d! inf = %0d\n",n_tb, nf_inf);
        end
        else if (Err_tb)
        begin
            $display("Error received, input = %0d", n_tb);
        end
        if ((nf_tb != nf_inf) && (n_tb <= 12))
        begin
            $display("Error: got %0d, expected %0d for $0d!",nf_tb, nf_inf, n_tb);
            $stop;
        end
        
        
        n_tb = n_tb + 4'd1;
    end
    
    
    $display("Test Complete");
    $finish;
end



endmodule
