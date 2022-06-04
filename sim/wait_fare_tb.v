/*
仿真思路：
	输入每脉冲的价格（BCD码），测试复位，启用，计满停止和价格计算功能是否正常
*/
`timescale 1ns/1ns
module wait_fare_tb ();

reg wait_fare_pulse;
reg rst_n;
reg wait_en;
reg max;
reg [11:0] wait_fare_per_unit;

wire [15:0] wait_fare_bcd;

parameter CYCLE = 5'd20;

always # 10 wait_fare_pulse = ~wait_fare_pulse;

initial begin
	wait_en = 1'b0;
    wait_fare_pulse = 1'b0;
    max = 1'b0;
	wait_fare_per_unit = 12'b0000_0001_0011;
	rst_n = 1'b0;
	#(CYCLE)
	rst_n = 1'b1;
	wait_en = 1'b1;
	#(CYCLE * 100);
	wait_en = 1'b0;
	#(CYCLE * 100);
	wait_en = 1'b1;
	#(CYCLE * 100);
    max = 1'b1;
	#(CYCLE * 100);
    max = 1'b0;
    #(CYCLE * 1000);
	$stop;
end

wait_fare wait_fare_test (
.wait_fare_pulse    (wait_fare_pulse    ),
.rst_n              (rst_n              ),
.wait_en            (wait_en            ),
.max                (max                ),
.wait_fare_per_unit (wait_fare_per_unit ),
	
.wait_fare_bcd      (wait_fare_bcd      )
);

endmodule
