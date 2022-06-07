/*
仿真思路：
	测试en，max，rst_n信号对分频模块的分频功能影响是否正常
*/
`timescale 1ns/1ns

module freq_div_tb();

reg clk;
reg en;
reg max;
reg rst_n;

wire min_pulse;

parameter MIN_COUNT = 4'd10;
parameter CYCLE = 5'd20;

always # 10 clk = ~clk;

initial begin
    clk = 1'b0;
	 en = 1'b0;
	 max = 1'b0;
	 rst_n = 1'b0;
	 #(CYCLE * 50)
	 rst_n = 1'b1;
	 en = 1'b1;
	 #(CYCLE * 100);
	 max = 1'd1;
	 #(CYCLE * 100);
	 max = 1'd0;
	 #(CYCLE * 100);
	 rst_n = 1'b0;
	 #(CYCLE * 100);
	 rst_n = 1'b1;
	 #(CYCLE * 100);
	 $stop;
end

freq_div#(
	.MIN_COUNT(MIN_COUNT)
) freq_div_test (
.clk		(clk		),
.rst_n		(rst_n		),
.en			(en			),
.max		(max		),
             
.min_pulse	(min_pulse	)
);

endmodule
