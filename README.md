VGA Controller IP
=================

A VGA Controller IP written in Verilog to output pretty colors to a VGA monitor in glorious 640x480 resolution. This IP was developed for the Zynq-7000 series of Programmable SOCs although it could easily be translated to other programmable logic devices.

There are four files you'll find in the HDL folder:
<ul>
<li>SyncGen.v - This is the sync generator that creates the correct horizontal and vertical sync pulses to output colors at a certain resolution. By default, the parameters are set for 640x480, but the timing values can be adjusted in the configuration window after being included into a Zynq design (or by modifying the verilog directly).</li>
<li>PixelLogic.v - This file creates the logic to determine what colors to output for each pixel. Right now, it just outputs bars of red, green, and blue, but in the future will be modified to read out of a framebuffer stored in DDR3 RAM.</li>
<li>VGA_Controller_v1_0_S_AXI.v - The auto-generated AXI wrapper that allows this IP to hook into an AXI interface. AXI is the primary bus system used in the Zynq-7000 series of chips, and by creating this IP to utilize AXI, it can be easily integrated into any Zynq based design.</li>
<li>VGA_Controller_v1_0.v - The top-level file that defines the ports and parameters needed to get the VGA controller running.</li>
</ul>

Beyond the HDL, you'll also find a simple testbench used to test the SyncGen module in the Sim folder. By running that testbench in a simulator, you'll be able to see the horizontal and vertical sync/blank signals and when they're triggered.