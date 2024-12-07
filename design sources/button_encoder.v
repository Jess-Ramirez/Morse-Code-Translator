`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 06:13:55 PM
// Design Name: 
// Module Name: button_encoder
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


module button_encoder(
    input clk,
    input send,
    input button,
    output reg [9:0] letter
);

parameter dot = 1;
parameter dash = 3;
reg [3:0] counter;
reg on;
reg prev_button;
reg [3:0]new;



initial begin
        counter = 0;
        letter = 10'b0000000000;
        prev_button = 0;
        on = 0;
        new = 0;
end


always @(posedge clk or posedge send) begin    

    if(send)begin // reset values
        counter <= 0;
        on <= 0;
        letter <= 10'b0000000000;
        prev_button <= 0;
    end
    else begin
        if(!button && prev_button && on) begin         // button was released so counter can stop
            if(counter < dash && counter >= dot) begin // counter is greater than dot parameter but less than dash
            letter <= {letter[7:0],2'b01};                           // add dot
            end
            
            else if(counter > dash)begin            // counter is greater than dash
            letter <= {letter[7:0],2'b11};                        // add dash
            end
            
            on = 0;                                 //button is no longer pressed so reset counter and on
            counter = 0;
        end
        
        else if(button && !prev_button)begin        //button is now being pressed
        counter = 0;
        on =1;
        end
        
        if(on)begin                                 //counter + 1 at every posedge cycle where button is on
        counter = counter +1;
        end
        
        prev_button = button;
   end
end
endmodule
