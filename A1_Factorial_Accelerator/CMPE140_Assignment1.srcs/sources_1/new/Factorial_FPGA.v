`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 02:07:27 PM
// Design Name: 
// Module Name: Factorial_FPGA
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


module Factorial_FPGA(
    input go, clk100MHz, man_clk,
    input [3:0] n,
    output [7:0] LEDSEL, LEDOUT,
    output done, err,
    output [3:0] n_out
    );
    
    supply1 [7:0] vcc;
    wire DONT_USE, clk_5KHz;
    wire debounced_clk;
    wire [31:0] nf;
    wire dummy;
    assign dummy = 0;
    assign n_out = n;
    
//    reg  [7:0] LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7;
    wire [7:0] LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7;
    wire [3:0] BCD0, BCD1, BCD2, BCD3, BCD4, BCD5, BCD6, BCD7;     
    
    Factorial_Top Top (
        .Go(go),
        .clk(debounced_clk),
        .Done(done),
        .Err(err),
        .n(n),
        .nf(nf)
     );
    
    button_debouncer DBNC (
        .clk(clk_5KHz),
        .button(man_clk),
        .debounced_button(debounced_clk)
    );
    
    led_mux LED (
        .clk(clk_5KHz),
        .rst(dummy),
        .LED0(LED0),
        .LED1(LED1),
        .LED2(LED2),
        .LED3(LED3),
        .LED4(LED4),
        .LED5(LED5),
        .LED6(LED6),
        .LED7(LED7),
        .LEDSEL(LEDSEL),
        .LEDOUT(LEDOUT)
    );
    
    clk_gen CLK (clk100MHz, dummy, DONT_USE, clk_5KHz);
    
    bin32_to_8hex B2HEX (
        .value(nf),
        .dig0(BCD0),
        .dig1(BCD1),
        .dig2(BCD2),
        .dig3(BCD3),
        .dig4(BCD4),
        .dig5(BCD5),
        .dig6(BCD6),
        .dig7(BCD7)
    );
    
    bcd_to_7seg B2LED0 (
        .BCD(BCD0),
        .s(LED0)
    );

    bcd_to_7seg B2LED1 (
        .BCD(BCD1),
        .s(LED1)
    );

    bcd_to_7seg B2LED2 (
        .BCD(BCD2),
        .s(LED2)
    );

    bcd_to_7seg B2LED3 (
        .BCD(BCD3),
        .s(LED3)
    );

    bcd_to_7seg B2LED4 (
        .BCD(BCD4),
        .s(LED4)
    );

    bcd_to_7seg B2LED5 (
        .BCD(BCD5),
        .s(LED5)
    );

    bcd_to_7seg B2LED6 (
        .BCD(BCD6),
        .s(LED6)
    );

    bcd_to_7seg B2LED7 (
        .BCD(BCD7),
        .s(LED7)
    );
    
    
    
    
    
    
endmodule
