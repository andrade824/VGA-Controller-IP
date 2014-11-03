`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Create Date: 05/26/2014 05:32:44 PM
// Design Name: Test Bench for Sync Generator
// Module Name: test_SyncGen
// Project Name: VGA_Controller
// Tool Versions: Vivado 2014.1
// 
//////////////////////////////////////////////////////////////////////////////////

module test_SyncGen;

    reg clk, rst;
    
    wire [9:0] hcount, vcount;
    wire hsync, vsync, hblank, vblank;
    
    SyncGen sync (
        .clk(clk),
        .rst(rst)
    );
    
    initial begin
        clk = 0;
        rst = 1;
        
        #33_444_000 $stop;
    end
    
    always begin
        #20 clk = ~clk;
    end
    
endmodule
