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


module rx2(
    input clk,
    input [31:0]data,
    output reg ready,
    //�ٶ�valid������ʱ �Ѿ����һ��
    input valid,
    output [31:0]data_show
    );
    
reg [31:0]datareg;
//����һ������
reg [63:0]data_cache;
//reg [31:0]readygen;
//���valid�½���
reg [1:0]valid_ff;
wire valid_neg;
wire valid_pos;

initial 
begin 
//     readygen = 32'd0;
     datareg  = 32'd0;
     ready = 1'd0;
     valid_ff = 2'd0;
end

always@(posedge clk)
begin
    valid_ff[0] <= valid;
    valid_ff[1] <= valid_ff[0];
end

always@(posedge clk)
begin
    data_cache[31:0] <= data;
    data_cache[63:32] <= data_cache[31:0];
end

assign valid_neg = valid_ff[0] & ~valid;
assign valid_pos = ~valid_ff[0] & valid;
assign data_show = datareg;

always@(posedge clk)
begin
    //���ֳɹ���ȡ������ ���ݳ���ȡ����validʱ�� �ӳ�һ�Ĳ�Ӱ�쳤��
    if(valid & ready)
          begin
            datareg <= data_cache[31:0];
          end
    else
        begin
            datareg <= datareg;
        end
end

always@(negedge clk)
begin
//׼������
    if(valid_pos & (~ready))
        begin
            ready <= 1'd1;
//            datareg <= data;
        end
    if(valid_neg & ready)
        begin
            ready <= 1'd0;
//            datareg <= datareg;
        end
end


endmodule
