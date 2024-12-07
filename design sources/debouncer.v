`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 08:58:55 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input button,
    output reg [1:0] clean
);

parameter MAX = 1;
reg counter;
reg on;

    always @(posedge clk) begin
    
        if(button && clean == 1'b0 && on == 1'b0) begin // if button is pushed, clean is 0 and button was not pressed
            if(counter < MAX) begin
            counter <= counter + 1;
            clean <= 0;
            end

            else begin // counter has reached max and so clean is set to 1
            clean <= 1;
            end
        end 
        
        else if (button == 1'b1 && clean == 1'b1) begin // if button is pressed and clean was set to 1
                                            //set on to 1 to keep state of button
            on <= 1'b1;
        end 
        
        else if(clean == 1'b1)begin //if button is no longer pressed and clean is still 1
            counter <= 0;           // then reset counter, clean and on to 0 
            clean <= 0;
            on <= 1'b0;             //button is no longer pressed
        end
        
        else begin // reset values
            counter <= 0; 
            clean <= 0;
            on <= 0;
        end
        
    end
    
endmodule