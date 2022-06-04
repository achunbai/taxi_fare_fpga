//分频模块
//将50MHz输入时钟分成分钟输出
/*
clk		-> 输入的时钟信号
rst_n		-> 输入的复位信号
en		-> 输入的使能信号
max		-> 输入的计满信号，由fee_total模块产生

min_pulse	-> 输出的分钟脉冲
*/
module freq_div (
	input wire clk,
	input wire rst_n,
	input wire en,
	input wire max,
	
	output wire min_pulse
);

parameter MIN_COUNT = 32'd3_000_000_000;

reg [31:0] min_counter = MIN_COUNT;
reg min = 1'd0;

assign min_pulse = min;

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		min_counter <= MIN_COUNT;
		min <= 1'd0;
	end
	else if (min_counter == 1'd1) begin
		min_counter <= MIN_COUNT;
		min <= ~min;
	end
	else if(en && !max) begin
		min_counter <= min_counter - 1'd1;
	end
	else begin
		min_counter <= min_counter;
	end
end

endmodule
