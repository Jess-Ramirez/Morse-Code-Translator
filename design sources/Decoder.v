`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2024 12:08:29 PM
// Design Name: 
// Module Name: Decoder
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


module decoder(
    input reset,
    input [7:0] letterBits,
    output reg [4:0] letterNum,
    output reg reading
    );
    
    initial begin
    reading = 1'b0;
    letterNum = 5'b00000;
    end
    
    always @(posedge reset) begin
        reading = 1'b1;
        case(letterBits)
            8'b00000111: letterNum = 5'b00001;		//1, A
            8'b11010101: letterNum = 5'b00010;
            8'b11011101: letterNum = 5'b00011;
            8'b00110101: letterNum = 5'b00100;
            8'b00000001: letterNum = 5'b00101;
            8'b01011101: letterNum = 5'b00110;
            8'b00111101: letterNum = 5'b00111;
            8'b01010101: letterNum = 5'b01000;
            8'b00000101: letterNum = 5'b01001;
            8'b01111111: letterNum = 5'b01010;
            8'b00110111: letterNum = 5'b01011;
            8'b01110101: letterNum = 5'b01100;
            8'b00001111: letterNum = 5'b01101;
            8'b00001101: letterNum = 5'b01110;
            8'b00111111: letterNum = 5'b01111;
            8'b01111101: letterNum = 5'b10000;		//16, P
            8'b11110111: letterNum = 5'b10001;
            8'b00011101: letterNum = 5'b10010;
            8'b00010101: letterNum = 5'b10011;
            8'b00000011: letterNum = 5'b10100;
            8'b00010111: letterNum = 5'b10101;
            8'b01010111: letterNum = 5'b10110;
            8'b00011111: letterNum = 5'b10111;
            8'b11010111: letterNum = 5'b11000;
            8'b11011111: letterNum = 5'b11001;
            8'b11110101: letterNum = 5'b11010;		//26, Z
        endcase
    end
    
endmodule
