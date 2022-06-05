//等候时间计数模块
//十分钟输出一个计费脉冲
//这个模块可以整合进分频模块里面的，但是目前能稳定运行暂时就先不动了:D
/*
min_pulse		-> 输入的分钟脉冲信号
rst_n			-> 输入的下降沿有效的复位信号

wait_fare_pulse	-> 输出的计费信号
*/
module wait_count (
	input wire min_pulse,
	input wire rst_n,
	
	output wire wait_fare_pulse
);

//定义参数WAIT_COUNT，等待的时间，单位是分钟，方便后续修改及仿真时覆写
//每十分钟含有10个时钟周期，但是这里只检测了上跳沿
//所以是每五个周期（五分钟）翻转一次输出脉冲信号
parameter WAIT_COUNT = 4'd5;

reg [3:0] counter = WAIT_COUNT;
reg wait_fare = 1'd0;

//防止出现不定态，先给寄存器赋初值，后赋给wire类型变量
assign wait_fare_pulse = wait_fare;

always@(posedge min_pulse or negedge rst_n) begin
	//判断复位信号，为低电平则将计数器初始化为WAIT_COUNT的值，并输出低电平
	if (!rst_n) begin
		counter <= WAIT_COUNT;
		wait_fare <= 1'd0;
	end
	//判断是否达到计费单位的分钟数，若达到则将输出脉冲翻转
	else if (counter == 1'd1) begin
		wait_fare <= ~wait_fare;
		counter <= WAIT_COUNT;
	end
	//若上述条件都不满足，则开始计数
	else begin
		counter <= counter - 1'd1;
	end
end

endmodule
