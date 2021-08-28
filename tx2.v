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

module tx2(
    input clk,
    output [31:0]data,
    output reg valid,
    input  ready
    );
    
reg [31:0]datareg;
reg [31:0]datagen;
reg init_tx;
reg [2:0]datacount;
assign data = datareg;

initial 
begin 
     datareg = 32'd0;
     datagen = 32'd0;
     init_tx = 1'd0;
     datacount = 3'd0;
     valid <=1'd0;
end

always@(posedge clk)
begin
     datagen <= datagen + 32'd1;
end

//提前缓存一格数据
reg [31:0]data_ff;
always@(posedge clk or posedge ready)
begin
    if(init_tx)
        begin
            //数据长度到达
            if( datacount == 3'd7)
                begin   
                    valid<=1'd0;
                end
            else 
                begin   
                    valid<=1'd1;
                end
            
            if(ready)
            begin
                datacount <= datacount + 3'd1;
                //防止越界
                if( datacount == 3'd7)
                    begin   
                       datareg <= {29'd0,datacount}+32'd1;
                    end
                else 
                //满足时序
                    begin   
                       datareg <= {29'd0,datacount+1}+32'd1;
                    end
                end
            else
              begin
                 datareg <= {29'd0,datacount}+32'd1;
              end
        end
    else
        begin
            valid<=1'd0;
            datareg <= 32'd0;
        end
end

always@(posedge clk)
begin
    // 假定data和valid 同时准备好了
   if(datacount == 3'd7)
       begin
           init_tx <= 1'd0;
       end
   else 
       if (datacount == 3'd0)
           begin
               begin
               if(datagen & 32'd8)
                 begin
                    init_tx <= 1'd1;
                 end
               else
                begin
                    init_tx <= 1'd0;
                end
               end
           end
       else
           begin
                init_tx <= init_tx;
           end
end

endmodule
