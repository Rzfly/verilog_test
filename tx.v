`timescale 10ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/27 10:19:47
// Design Name: 
// Module Name: tx
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

module tx(
    input clk,
    output [31:0]data,
    output reg valid,
    input  ready
    );
    
reg [31:0]datareg;
reg [31:0]datagen;
assign data = datareg;

initial 
begin 
     datareg = 32'd0;
     datagen = 32'd0;
end

always@(posedge clk)
begin
    datagen <= datagen + 1;
end

always@(posedge clk)
begin
    // 假定data和valid 同时准备好了
    if(datagen & 32'd8)
       begin 
            valid <= 1'd1;
            datareg <= datagen;
       end
    else
       begin
            valid <= 1'd0;
            datareg <= 32'd0;
       end
end


//always@(posedge clk)
//begin
//    // 假定data和valid 同时准备好了
//    if(valid)
//       begin 
//            valid <= 1'd1;
//            datareg <= datagen;
//       end
//    else
//       begin
//            valid <= 1'd0;
//            datareg <= 32'd0;
//       end
//end

endmodule
