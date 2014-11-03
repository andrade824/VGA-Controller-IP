`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Create Date: 05/26/2014 04:38:00 PM
// Design Name: Sync Generator
// Module Name: SyncGen
// Project Name: VGA IP
// Target Devices: xc7z010clg400-1
// Tool Versions: Vivado 2014.1
// Description: 
// 
//  640x480 Resolution
//    HSYNC_ON = 655,
//    HSYNC_OFF = 751,
//    HBLANK_ON = 639,
//    HBLANK_OFF = 799,
//    
//    // Vertical timing parameters
//    VSYNC_ON = 489,
//    VSYNC_OFF = 491,
//    VBLANK_ON = 479,
//    VBLANK_OFF = 520
//
//////////////////////////////////////////////////////////////////////////////////

module SyncGen #(
    // Width of counters
    parameter WIDTH = 10,
    
    // Horizontal timing parameters
    parameter HSYNC_ON = 655,
    parameter HSYNC_OFF = 751,
    parameter HBLANK_ON = 639,
    parameter HBLANK_OFF = 799,
    
    // Vertical timing parameters
    parameter VSYNC_ON = 489,
    parameter VSYNC_OFF = 491,
    parameter VBLANK_ON = 479,
    parameter VBLANK_OFF = 520
)
(
    input wire clk, rst,
    output reg [WIDTH-1:0] hcount, vcount,
    output reg hsync, vsync, hblank, vblank
);

    // Determines when to turn on sync and blank signals
    assign hsync_on = (hcount == HSYNC_ON);
    assign hsync_off = (hcount == HSYNC_OFF);
    assign hblank_on = (hcount == HBLANK_ON);
    assign hblank_off = (hcount == HBLANK_OFF);
    assign vsync_on = (vcount == VSYNC_ON);
    assign vsync_off = (vcount == VSYNC_OFF);
    assign vblank_on = (vcount == VBLANK_ON);
    assign vblank_off = (vcount == VBLANK_OFF);
    
    initial begin
        hcount = {WIDTH{1'b0}};
        vcount = {WIDTH{1'b0}};
        hsync = 1'b0;
        hblank = 1'b0;
        vsync = 1'b0;
        vblank = 1'b0;
    end
    
    // Horizontal counter
    always @(posedge clk or negedge rst) begin
        if(!rst)
            hcount = {WIDTH{1'b0}};
        else if (hcount <= HBLANK_OFF - 1)
            hcount = hcount + 1;
        else
            hcount = {WIDTH{1'b0}};
    end
    
    // Horizontal Sync
    always @(posedge clk or negedge rst) begin
        if(!rst)
            hsync = 1'b0;
        else if (hsync_on)
            hsync = 1'b1;
        else if (hsync_off)
            hsync = 1'b0;
        else
            hsync = hsync;
    end
    
    // Horizontal Blank
    always @(posedge clk or negedge rst) begin
        if(!rst)
            hblank = 1'b0;
        else if (hblank_on)
            hblank = 1'b1;
        else if (hblank_off)
            hblank = 1'b0;
        else
            hblank = hblank;
    end

    // Vertical counter
    always @(posedge clk or negedge rst) begin
        if(!rst)
            vcount = {WIDTH{1'b0}};
        else if (hsync_on) begin
            if(vcount <= VBLANK_OFF - 1)
                vcount = vcount + 1;
            else
                vcount = {WIDTH{1'b0}};
        end else
            vcount = vcount;
    end
    
    // Vertical Sync
    always @(posedge clk or negedge rst) begin
        if(!rst)
            vsync = 1'b0;
        else if (vsync_on)
            vsync = 1'b1;
        else if (vsync_off)
            vsync = 1'b0;
        else
            vsync = vsync;
    end
    
    // Vertical Blank
    always @(posedge clk or negedge rst) begin
        if(!rst)
            vblank = 1'b0;
        else if (vblank_on)
            vblank = 1'b1;
        else if (vblank_off)
            vblank = 1'b0;
        else
            vblank = vblank;
    end

endmodule
