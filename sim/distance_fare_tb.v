/*
仿真思路：
	输入起步价，每十米价格测试是否正常运行
	主要测试使能，复位和计满停止功能是否正常
*/
`timescale 1ns/1ns

module distance_fare_tb();

reg ten_meter_pulse;
reg en;
reg [11:0] distance_fare_per_pulse;
reg [11:0] s_fare;
	
wire [15:0] distance_bcd;
wire [15:0] distance_fare_bcd;

parameter CYCLE = 5'd20;

always # 100 ten_meter_pulse = ~ten_meter_pulse;

initial begin
		en = 1'b0;
		rst_n = 1'b0;
		ten_meter_pulse = 1'b0;
		distance_fare_per_pulse = 12'b0000_0000_0011;
		s_fare = 12'b0011_0000_0000;
		pulses_per_km = 12'b0001_0000_0000;
	#(CYCLE);
		rst_n = 1'b1;
	#(CYCLE * 50);
		en = 1'b1;
	#(CYCLE * 1200);
		rst_n = 1'b0;
	#(CYCLE * 10);
		$stop;
end

distance_fare distance_fare_test (
.ten_meter_pulse			(ten_meter_pulse			),
.en							(en							),
.distance_fare_per_pulse	(distance_fare_per_pulse	),
.s_fare						(s_fare						),
.rst_n						(rst_n						),
	                   	
.distance_bcd				(distance_bcd				),
.distance_fare_bcd			(distance_fare_bcd			)
);

endmodule
