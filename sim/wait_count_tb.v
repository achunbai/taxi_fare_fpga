/*
仿真思路：
	测试分频功能以及复位功能是否正常
*/
`timescale 1ns/1ns

module wait_count_tb();

reg min_pulse;
reg rst_n;

wire wait_fare_pulse;

parameter CYCLE = 5'd20;
parameter WAIT_COUNT = 4'd5;

always # 10 min_pulse = ~min_pulse;

initial begin
    min_pulse = 1'b0;
	 min_pulse = 1'b0;
	 rst_n = 1'b0;
	 #(CYCLE * 500)
	 rst_n = 1'b1;
	 #(CYCLE * 500)
	 $stop;
end

wait_count#(
	.WAIT_COUNT(WAIT_COUNT)
)  wait_count_test (
.min_pulse		(min_pulse		),
.rst_n			(rst_n			),
                
.wait_fare_pulse(wait_fare_pulse)
);

endmodule
