`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 09:26:35 PM
// Design Name: 
// Module Name: fpga_top
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


module fpga_top(
    input  wire       clk100MHz,
    input  wire       button_clk,
    input  wire       button_rst,
    input  wire [3:0] n,
    input  wire     Sel, 
    output wire [7:0] LEDSEL,
    output wire [7:0] LEDOUT,
    output wire       factErr,
    output wire [15:0] hex_out
    );

    
    wire  [31:0] reg_hex;
    wire        clk_sec;
    wire        clk_5KHz;
    wire        rst;
    wire        clk_man;
    
    wire [31:0] gpi1_int, gpi2_int;                
    wire [31:0] gpO1_out;
    
    assign gpi1_int = {27'b0, Sel, n[3], n[2], n[1], n[0]};
    assign gpi2_int = gpO1_out;
    assign factErr = gpO1_out[0];  
    
    assign hex_out = reg_hex[15:0];              

    wire [7:0]  digit0;
    wire [7:0]  digit1;
    wire [7:0]  digit2;
    wire [7:0]  digit3;
    wire [7:0]  digit4;
    wire [7:0]  digit5;
    wire [7:0]  digit6;
    wire [7:0]  digit7;


    clk_gen clk_gen (
            .clk100MHz          (clk100MHz),
            .clk_4sec           (clk_sec),
            .clk_5KHz           (clk_5KHz),
            .rst                (button_rst)
        );

    button_debouncer bd_rst (
            .clk                (clk_5KHz),
            .button             (button_rst),
            .debounced_button   (rst)
        );
        
    button_debouncer bd_clk (
            .clk                (clk_5KHz),
            .button             (button_clk),
            .debounced_button   (clk_man)
        );
        
    system system (
        .gpi1                (gpi1_int),
        //.gpi2                (gpO1_out),
        .gpi2                (gpi2_int),
        .gpO1                (gpO1_out),
        .gpO2                (reg_hex),
        .clk                 (clk_5KHz),
        //.clk                 (clk_man),
        //.clk                 (button_clk),
        .reset               (rst)
        //.reset               (button_rst)     
    );
        
        
    

    hex_to_7seg hex7 (
            .HEX                (reg_hex[31:28]),
            .s                  (digit7)
        );

    hex_to_7seg hex6 (
            .HEX                (reg_hex[27:24]),
            .s                  (digit6)
        );

    hex_to_7seg hex5 (
            .HEX                (reg_hex[23:20]),
            .s                  (digit5)
        );

    hex_to_7seg hex4 (
            .HEX                (reg_hex[19:16]),
            .s                  (digit4)
        );
    
    hex_to_7seg hex3 (
            .HEX                (reg_hex[15:12]),
            .s                  (digit3)
        );

    hex_to_7seg hex2 (
            .HEX                (reg_hex[11:8]),
            .s                  (digit2)
        );

    hex_to_7seg hex1 (
            .HEX                (reg_hex[7:4]),
            .s                  (digit1)
        );

    hex_to_7seg hex0 (
            .HEX                (reg_hex[3:0]),
            .s                  (digit0)
        );

    led_mux led_mux (
            .clk                (clk_5KHz),
            //.clk                (button_clk),
            .rst                (rst),
            .LED7               (digit7),
            .LED6               (digit6),
            .LED5               (digit5),
            .LED4               (digit4),
            .LED3               (digit3),
            .LED2               (digit2),
            .LED1               (digit1),
            .LED0               (digit0),
            .LEDSEL             (LEDSEL),
            .LEDOUT             (LEDOUT)
        );
    
    /*
    switches [7:5] = 000: Display word of register selected by switches[4:0]
    
    switches [7:5] = 001: Display word of instr
    
    switches [7:5] = 010: Display word of 'alu_out'
    
    switches [7:5] = 011: Display word of 'wd_dm'
    
    switches [7:5] = 1XX : Display word of 'pc_current'
    */
//    always @ (posedge clk100MHz) begin
//        casez ({switches[7:5]})
//            3'b000: reg_hex  = dispData[31:0];
//            3'b001: reg_hex  = instr[31:0];
//            3'b010: reg_hex  = alu_out[31:0];
//            3'b011: reg_hex  = wd_dm[31:0];
//            3'b1??: reg_hex  = pc_current[31:0];
//            default: reg_hex = pc_current[31:0];
//        endcase
//    end




    
endmodule
