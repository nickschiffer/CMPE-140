`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2019 07:28:45 PM
// Design Name: 
// Module Name: bin32_to_8hexs
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

module bin32_to_8hex( 
    input wire [31:0] value, 
    output wire [3:0] dig0, 
    output wire [3:0] dig1, 
    output wire [3:0] dig2, 
    output wire [3:0] dig3, 
    output wire [3:0] dig4, 
    output wire [3:0] dig5, 
    output wire [3:0] dig6, 
    output wire [3:0] dig7 
    ); 
    //    assign dig0 = value % 10; 
    //    assign dig1 = (value / 10) % 10; 
    //    assign dig2 = (value / 100) % 10; 
    //    assign dig3 = (value / 1000) % 10; 
    //    assign dig4 = (value / 10000) % 10; 
    //    assign dig5 = (value / 100000) % 10; 
    //    assign dig6 = (value / 1000000) % 10; 
    //    assign dig7 = (value / 10000000) % 10;

    // assign dig0 = value                    % (1 << 4); 
    // assign dig1 = (value / (1 << (4 * 1))) % (1 << 4); 
    // assign dig2 = (value / (1 << (4 * 2))) % (1 << 4); 
    // assign dig3 = (value / (1 << (4 * 3))) % (1 << 4); 
    // assign dig4 = (value / (1 << (4 * 4))) % (1 << 4); 
    // assign dig5 = (value / (1 << (4 * 5))) % (1 << 4); 
    // assign dig6 = (value / (1 << (4 * 6))) % (1 << 4); 
    // assign dig7 = (value / (1 << (4 * 7))) % (1 << 4);

//     assign dig0 = value              % (1 << 4); 
//     assign dig1 = (value >> (4 * 1)) % (1 << 4); 
//     assign dig2 = (value >> (4 * 2)) % (1 << 4); 
//     assign dig3 = (value >> (4 * 3)) % (1 << 4); 
//     assign dig4 = (value >> (4 * 4)) % (1 << 4); 
//     assign dig5 = (value >> (4 * 5)) % (1 << 4); 
//     assign dig6 = (value >> (4 * 6)) % (1 << 4); 
//     assign dig7 = (value >> (4 * 7)) % (1 << 4);

    assign {dig7, dig6, dig5, dig4, dig3, dig2, dig1, dig0} = value;
endmodule
