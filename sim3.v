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


module sim3(

    );
    
    wire  [31:0]data;
    wire  valid;
    wire  ready;
    wire  [31:0]data_show;
    reg ready_late_reg;
    reg valid_late_reg;
    reg clk;

//    wire data_late;
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
   //#1 ~ #5没问题
   //引入总线延时
   assign #2 valid_late = valid;
   assign #2 ready_late = ready;
   always@(posedge clk)
   begin
        ready_late_reg <= ready_late;
        valid_late_reg <= valid_late;
   end

    tx3 tx_inst(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_late_reg)
    );
  
    rx3 rx_inst(
        .clk(clk),
        .data(data),
        .valid(valid_late_reg),
        .ready_out(ready),
        .data_show(data_show)
    );
    
    
endmodule
