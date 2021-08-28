`timescale 10ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/27 11:49:28
// Design Name: 
// Module Name: sim
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


module sim(

    );
    
    wire  [31:0]data;
    wire  valid;
    wire  ready;
    wire  [31:0]data_show;
    reg clk;
    wire data_late;
    wire valid_late;
    wire ready_late;
    initial
    begin
        clk <= 1'd1;
    end
    always@(*)
    begin
        //cycle = 20ns, 50Mhz
        #5 clk <= ~clk;    
    end
   assign  valid_late = valid;
//   assign  data_late = data;
   assign  ready_late = ready;

    tx tx_inst(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_late)
    );
    
    rx rx_inst(
        .clk(clk),
        .data(data),
        .valid(valid_late),
        .ready(ready),
        .data_show(data_show)
    );
    
    
endmodule
