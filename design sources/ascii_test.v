`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 04:36:59 PM
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
    input clkdiv,
    input send,
    input reset,
    input video_on,
    input [9:0] x, y,
    input [5:0] letterNum,
    output reg vga_r
    );
    
    // signal declarations
//    wire [10:0] rom_addr;           // 11-bit text ROM address
    wire [6:0] ascii_char;          // 7-bit ASCII character code
    wire [3:0] char_row;            // 4-bit row of ASCII character
    wire [2:0] bit_addr;            // column number of ROM data
    wire [7:0] rom_data;            // 8-bit row data from text ROM
    wire ascii_bit, ascii_bit_on;     // ROM bit and status signal
    reg [9:0] xDisp;
    reg [5:0] count;
    integer i;
    reg [5:0] index;
    reg [5:0] tempLett;

    
    initial begin
    xDisp = 192;
    count = 0;
    index = 0;
    end
    
    ascii_rom2 rom(.clk(clk), .letterNum(xLetter[index]), .row(char_row), .data(rom_data));

    // ASCII ROM interface

    assign ascii_bit = rom_data[~bit_addr];     // reverse bit order

    assign char_row = y[3:0];               // row number of ascii character rom
    assign bit_addr = x[2:0];               // column number of ascii character rom
    

    // "on" region in center of screen
     
     reg [9:0] xPositions[0:31];
     reg [5:0] xLetter [0:31];
   
   
    always @(posedge clkdiv or posedge reset)begin
    if(reset)begin
    count = 0;
    xDisp = 192;    
    end
    
    else if(count < 32 && send)begin
        xPositions[count] = xDisp;
        xLetter[count] = letterNum;
        xDisp <= xDisp + 8;
        count <= count + 1;

    end
 
    end
    
    
    reg bit_temp;
    
    always@(clk) begin
        bit_temp = 1'b0;
        for (i = 0; i < count; i = i + 1) begin
        if (((x >= xPositions[i] && x < (xPositions[i] + 8) ) && (y >= 208 && y < 224)))begin
        bit_temp = ascii_bit | bit_temp;
        index <= i;
        end
        end
    end
    
    
    assign ascii_bit_on = bit_temp;
    
    
    // rgb multiplexing circuit
    always @(clk)begin
    if(~video_on)
            vga_r = 1'b0;      
        else if(ascii_bit_on)
            vga_r = 1'b1;  
        else
            vga_r = 1'b0;  
    end
   
endmodule
