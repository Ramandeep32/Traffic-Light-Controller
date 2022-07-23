`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2022 13:57:33
// Design Name: 
// Module Name: Bcd_sevensegment
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


module Bcd_sevensegment(b,s);
input [2:0]b;
output [6:0] s;
reg [6:0] s;
always @(b)
    begin
        case (b) //case statement
            0 : s  = 7'b1000000;
            1 : s = 7'b1111001;
            2 : s = 7'b0100100;
            3 : s = 7'b0110000;
            4 : s = 7'b0011001;
            5 : s = 7'b0010010;
            6 : s = 7'b0000010;
            7 : s = 7'b1111000;
            8 : s = 7'b0000000;
            9 : s = 7'b0010000;
            default : s = 7'b0111111;

            endcase
    end
endmodule
