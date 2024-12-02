`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 04:28:33 PM
// Design Name: 
// Module Name: top
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


module vga_TOP(
    input clk,          // 100MHz on Basys 3
    input reset,        // btnC on Basys 3
    input send,
    input button,
    output [7:0] letter,
    output [1:0] dod,
    output hsync,       // to VGA connector
    output vsync,       // to VGA connector
    output vga_r   // to DAC, to VGA connector
    );
    
    // signals
    wire [9:0] w_x, w_y;
    wire w_video_on, w_p_tick;
    reg vga_reg;
    wire vga_next;
    wire [7:0]letterB =letter;
    wire [4:0] letterNum;
    
    // VGA Controller
    vga_controller vga(.clk_100MHz(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                       .video_on(w_video_on), .p_tick(w_p_tick), .x(w_x), .y(w_y));
    // Text Generation Circuit
    clk_divider clkdiv(.clk_in(clk),.rst(reset),.divided_clk(clk_div));
    button_encoder in(.clk(clk_div), .reset(send), .button(button),.letter(letter) , .dod(dod));
    decoder let(.reset(send),.letterBits(letterB),.letterNum(letterNum));

    ascii_test at(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .letterNum(letterNum), .vga_r(vga_next));
    
    // rgb buffer
    always @(posedge clk)
        if(w_p_tick)
            vga_reg <= vga_next;
            
    // output
    assign vga_r = vga_reg;
      
endmodule
