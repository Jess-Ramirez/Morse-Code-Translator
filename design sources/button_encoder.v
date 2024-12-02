`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 10:25:36 AM
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
    input reset,
    input button,
    output reg [7:0] letter,
    output reg [1:0] dod
);

parameter dot = 2;
parameter dash = 4;
reg [3:0] counter;
reg on;
reg prev_button;
reg [3:0]new;



initial begin
        counter = 0;
        letter = 2'b00;
        prev_button = 0;
        on = 0;
        new = 0;
end


always @(posedge clk or posedge reset) begin    

    if(reset)begin // reset values
        counter <= 0;
        on <= 0;
        letter <= 8'b0000000;
        prev_button <= 0;
    end
    else begin
        if(!button && prev_button && on) begin         // button was released so counter can stop
            if(counter < dash && counter >= dot) begin // counter is greater than dot parameter but less than dash
            letter <= {letter[5:0],2'b01};                           // add dot
            dod = 2'b01;
            end
            
            else if(counter > dash)begin            // counter is greater than dash
            letter <= {letter[5:0],2'b11};                        // add dash
            dod = 2'b10;
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

