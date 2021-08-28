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


module rx3(
    input clk,
    input [31:0]data,
    output ready_out,
    input valid,
    output [31:0]data_show
    );
    
reg [31:0]datareg;
//reg [31:0]readygen;
//���valid�½���
reg [1:0]valid_ff;
wire valid_neg;
wire valid_pos;
reg ready;
initial 
begin 
//     readygen = 32'd0;
     datareg  = 32'd0;
     ready = 1'd0;
     valid_ff = 2'd0;
end

//assign data = datareg;
//always@(posedge clk)
//begin
//    readygen <= readygen + 1;
//end

//always@(posedge clk)
//begin
//    // ����ready�ź�
//    if(readygen & 32'd8)
//       begin 
//            ready <= 1'd1;
//       end
//    else
//       begin 
//            ready <= 1'd0;
//       end
//end

always@(posedge clk)
begin
    valid_ff[0] <= valid;
    valid_ff[1] <= valid_ff[0];
end

assign valid_neg = valid_ff[0] & ~valid;
assign valid_pos = ~valid_ff[0] & valid;
assign data_show = datareg;

always@(posedge clk )
begin
    //���ֳɹ���ȡ������
    if(valid & ready)
          begin
            datareg <= data;
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
        end
    if(valid_neg & ready)
        begin
            ready <= 1'd0;
        end
end

assign ready_out = ready & valid;
endmodule
