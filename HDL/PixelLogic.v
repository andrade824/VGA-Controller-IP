`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Create Date: 05/26/2014 04:38:00 PM
// Design Name: Pixel Logic
// Module Name: PixelLogic
// Project Name: VGA IP
// Target Devices: xc7z010clg400-1
// Tool Versions: Vivado 2014.1
// Description: 
// 
//////////////////////////////////////////////////////////////////////////////////

module PixelLogic(
    input wire clk, rst,
    input wire [9:0] hcount, vcount,
    input wire hblank, vblank,
    output wire [4:0] red, blue,
    output wire [5:0] green
);

    assign blanking = hblank | vblank;
    assign red = (hcount <= 212) ? 5'b11111 : 5'b0;
    assign blue = (hcount > 212 && hcount <= 600) ? 5'b11111 : 5'b0;
    assign green = (hcount > 600 && hcount <= 639) ? 6'b111111 : 6'b0;

endmodule
