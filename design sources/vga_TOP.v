`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 04:35:26 PM
// Design Name: 
// Module Name: vga_TOP
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
    input clk,          
    input conReset,        // resets screen
    input reset,            //stops the clock
    input send,
    input button,
    output [9:0] letter,    //Sent to LED's to show if a . or - was inputted
    output hsync,       // to VGA connector
    output vsync,       // to VGA connector
    output vga_r,   // to DAC, to VGA connector
    output sendoff, //connects to LED that corresponds to the send-button being live
    output clkLed    //connects to the LED that corresponds to a positive clock cycle
    );
    
    // signals
    wire [9:0] w_x, w_y;
    wire w_video_on, w_p_tick;
    reg vga_reg;
    wire vga_next;
    wire [9:0]letterB =letter;
    wire [5:0] letterNum;
    wire cleanSend;

    // VGA Controller
    vga_controller vga(.clk_100MHz(clk), .reset(conReset), .hsync(hsync), .vsync(vsync),
                       .video_on(w_video_on), .p_tick(w_p_tick), .x(w_x), .y(w_y));
    // Text Generation Circuit
    clk_divider clkdiv(.clk_in(clk),.rst(reset),.divided_clk(clk_div));
    assign clkLed = clk_div;
    
    debouncer sendDebouncer(.clk(clk_div), .button(send), .clean(cleanSend) );
    assign sendoff = cleanSend;
    
    button_encoder in(.clk(clk_div), .send(cleanSend), .button(button),.letter(letter));
    
    decoder let(.send(cleanSend),.letterBits(letterB),.letterNum(letterNum));

    ascii_test let2(.clk(clk), .clkdiv(clk_div), .send(cleanSend),.reset(reset),.video_on(w_video_on), .x(w_x), .y(w_y), .letterNum(letterNum), .vga_r(vga_next));

     
    // rgb buffer
    always @(posedge clk)begin
     if(w_p_tick)
            vga_reg <= vga_next;
     end       

      assign vga_r = vga_reg;
endmodule

