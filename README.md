# verilog_test
verilog_quizs

verilog仿真小测试！原题描述如下：


总线握手场景描述：
a) 总线master发出data信号，同时master用valid信号拉高表示data有效；
b) 总线slave发出ready信号，ready信号拉高表示slave可以接收数据；
c) 当valid和slave同时为高时，表示data信号从master到slave发送接收成功。

要求：
1) 实现上述总线握手场景；
2) 假定master的valid信号不满足时序要求，要对valid信号用寄存器打一拍，实现该总线握手场景；
3) 假定slave的ready信号不满足时序要求，要对ready信号用寄存器打一拍，实现该总线握手场景；
4) 假定valid和ready信号都不满足时序要求，都需要用寄存器打一拍，实现该总线握手场景。

项目文件描述如下
四个simx.v文件对应四个问题的testbench 分别可以跑出对应图片序号的结果。
其他文件是描述总线master和总线slave电路的源文件，master侧命名为tx，slave侧命名为rx。

sim0 调用 tx rx。

sim0 调用 tx rx2。

sim0 调用 tx2 rx。

sim0 调用 tx3 rx3。
