`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 17:46:58
// Design Name: 
// Module Name: uart_rx_tb
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


`timescale 1ns / 1ps

module uart_rx_tb;

reg clk;
reg reset;
reg rx;

wire [7:0] data_out;
wire rx_done;

uart_rx uut(
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .data_out(data_out),
    .rx_done(rx_done)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    rx = 1;

    #10;
    reset = 0;

    //------------------------------------
    // Receive 8'b10101010 (AA)
    //------------------------------------

    rx = 0; #10; // Start Bit

    rx = 0; #10;
    rx = 1; #10;
    rx = 0; #10;
    rx = 1; #10;
    rx = 0; #10;
    rx = 1; #10;
    rx = 0; #10;
    rx = 1; #10;

    rx = 1; #10; // Stop Bit

    #30;

    //------------------------------------
    // Receive 8'b11001100 (CC)
    //------------------------------------

    rx = 0; #10; // Start Bit

    rx = 0; #10;
    rx = 0; #10;
    rx = 1; #10;
    rx = 1; #10;
    rx = 0; #10;
    rx = 0; #10;
    rx = 1; #10;
    rx = 1; #10;

    rx = 1; #10; // Stop Bit

    #50;

    $finish;
end

endmodule
