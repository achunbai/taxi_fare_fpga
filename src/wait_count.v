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

parameter WAIT_COUNT = 4'd10;

reg [3:0] counter;
reg wait_fare = 1'd0;
assign wait_fare_pulse = wait_fare;

always@(posedge min_pulse or negedge rst_n) begin
	if (!rst_n) begin
		counter <= WAIT_COUNT;
		wait_fare <= 1'd0;
	end
	else if (counter == 1'd1) begin
		wait_fare <= ~wait_fare;
		counter <= WAIT_COUNT;
	end
	else begin
		counter <= counter - 1'd1;
	end
end

endmodule
