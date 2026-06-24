`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 17:46:37
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(
    input clk,
    input reset,
    input rx,
    output reg [7:0] data_out,
    output reg rx_done
);

reg [3:0] bit_count;
reg [7:0] rx_shift;
reg receiving;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        bit_count <= 0;
        rx_shift <= 8'b0;
        data_out <= 8'b0;
        rx_done <= 0;
        receiving <= 0;
    end
    else
    begin
        rx_done <= 0;

        // Detect Start Bit
        if(!receiving && rx == 0)
        begin
            receiving <= 1;
            bit_count <= 0;
        end

        else if(receiving)
        begin
            if(bit_count < 8)
            begin
                rx_shift[bit_count] <= rx;
                bit_count <= bit_count + 1;
            end
            else
            begin
                data_out <= rx_shift;
                rx_done <= 1;
                receiving <= 0;
            end
        end
    end
end

endmodule
