`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 03:52:27 PM
// Design Name: 
// Module Name: ascii_test
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


module ascii_test(
    input clk,
    input video_on,
    input [9:0] x, y,
    input [4:0] letterNum,
    output reg vga_r
    );
    
    // signal declarations
//    wire [10:0] rom_addr;           // 11-bit text ROM address
    wire [6:0] ascii_char;          // 7-bit ASCII character code
    wire [3:0] char_row;            // 4-bit row of ASCII character
    wire [2:0] bit_addr;            // column number of ROM data
    wire [7:0] rom_data;            // 8-bit row data from text ROM
    wire ascii_bit, ascii_bit_on;     // ROM bit and status signal
    
    // instantiate ASCII ROM
       ascii_rom2 rom(.clk(clk), .letterNum(letterNum), .row(char_row), .data(rom_data));

    // ASCII ROM interface
    assign ascii_bit = rom_data[~bit_addr];     // reverse bit order

    assign char_row = y[3:0];               // row number of ascii character rom
    assign bit_addr = x[2:0];               // column number of ascii character rom
    // "on" region in center of screen
    assign ascii_bit_on = ((x >= 192 && x < 200) && (y >= 208 && y < 224)) ? ascii_bit : 1'b0;
    
    // rgb multiplexing circuit
    always @*
        if(~video_on)
            vga_r = 1'b0;      
        else
            if(ascii_bit_on)
                vga_r = 1'b1;  
            else
                vga_r = 1'b0;  
   
endmodule


