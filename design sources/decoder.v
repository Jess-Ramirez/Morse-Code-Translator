`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2024 01:58:46 PM
// Design Name: 
// Module Name: decoder
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
    input send,
    input [9:0] letterBits,
    output reg [5:0] letterNum
    );
     

       always @(posedge send) begin
        case(letterBits)
            10'b0000000000: letterNum = 6'b000000;
            10'b0000000111: letterNum = 6'b000001;		//1, A
            10'b0011010101: letterNum = 6'b000010;
            10'b0011011101: letterNum = 6'b000011;
            10'b0000110101: letterNum = 6'b000100;
            10'b0000000001: letterNum = 6'b000101;
            10'b0001011101: letterNum = 6'b000110;
            10'b0000111101: letterNum = 6'b000111;
            10'b0001010101: letterNum = 6'b001000;
            10'b0000000101: letterNum = 6'b001001;
            10'b0001111111: letterNum = 6'b001010;
            10'b0000110111: letterNum = 6'b001011;
            10'b0001110101: letterNum = 6'b001100;
            10'b0000001111: letterNum = 6'b001101;
            10'b0000001101: letterNum = 6'b001110;
            10'b0000111111: letterNum = 6'b001111;
            10'b0001111101: letterNum = 6'b010000;		//16, P
            10'b0011110111: letterNum = 6'b010001;
            10'b0000011101: letterNum = 6'b010010;
            10'b0000010101: letterNum = 6'b010011;
            10'b0000000011: letterNum = 6'b010100;
            10'b0000010111: letterNum = 6'b010101;
            10'b0001010111: letterNum = 6'b010110;
            10'b0000011111: letterNum = 6'b010111;
            10'b0011010111: letterNum = 6'b011000;
            10'b0011011111: letterNum = 6'b011001;
            10'b0011110101: letterNum = 6'b011010;		//26, Z
            10'b0111111111: letterNum = 6'b011011;		//27,1
            10'b0101111111: letterNum = 6'b011100;		//2
            10'b0101011111: letterNum = 6'b011101;		//3
            10'b0101010111: letterNum = 6'b011110;		//4
            10'b0101010101: letterNum = 6'b011111;		//5
            10'b1101010101: letterNum = 6'b100000;		//6
            10'b1111010101: letterNum = 6'b100001;		//7
            10'b1111110101: letterNum = 6'b100010;		//8
            10'b1111111101: letterNum = 6'b100011;		//9
            10'b1111111111: letterNum = 6'b100100;		//36,0
            default :letterNum = 6'b000000;

            
            
        endcase
    end
    
endmodule

