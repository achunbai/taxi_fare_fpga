//分频模块
//将50MHz输入时钟分成分钟输出
/*
clk			-> 输入的时钟信号
rst_n		-> 输入的复位信号
en			-> 输入的使能信号
max			-> 输入的计满信号，由fee_total模块产生

min_pulse	-> 输出的分钟脉冲
*/
module freq_div (
	input wire clk,
	input wire rst_n,
	input wire en,
	input wire max,
	
	output wire min_pulse
);

//定义参数MIN_COUNT，方便仿真模块覆写及后续改动
//每分钟包含3_000_000_000个时钟周期，但是这里只检测了上跳沿
//所以是每1_500_000_000个周期（半分钟）翻转一次输出脉冲信号
parameter MIN_COUNT = 32'd1_500_000_000;

reg [31:0] min_counter = MIN_COUNT;
reg min = 1'd0;

//防止出现不定态，先给寄存器赋初值，后赋给wire类型变量
assign min_pulse = min;

always@(posedge clk or negedge rst_n) begin
	//判断复位信号，为低电平则将计数器初始化为MIN_COUNT的值，并输出低电平
	if (!rst_n) begin
		min_counter <= MIN_COUNT;
		min <= 1'd0;
	end
	//判断是否达到一分钟，若达到一分钟则将输出脉冲翻转
	else if (min_counter == 1'd1) begin
		min_counter <= MIN_COUNT;
		min <= ~min;
	end
	//判断是否满足工作条件（en为高电平且max为低电平），满足则开始计数
	else if(en && !max) begin
		min_counter <= min_counter - 1'd1;
	end
	//若不满足工作条件则暂停技术，保持结果
	else begin
		min_counter <= min_counter;
	end
end

endmodule
