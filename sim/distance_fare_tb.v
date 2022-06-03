`timescale 1ns/1ns

module distance_fare_tb();

reg ten_meter_pulse;
reg en;
reg [11:0] distance_fare_per_pulse;
reg [11:0] pulses_per_km;
reg [11:0] s_fare;
	
wire [15:0] distance_bcd;
wire [15:0] distance_fare_bcd;

parameter CYCLE = 5'd20;
parameter MAX_NUM = 7'd100;

always # 100 ten_meter_pulse = ~ten_meter_pulse;

initial begin
		en = 1'b0;
		ten_meter_pulse = 1'b0;
		distance_fare_per_pulse = 12'b0000_0000_0011;
		s_fare = 12'b0011_0000_0000;
		pulses_per_km = 12'b0001_0000_0000;
	 #(MAX_NUM * CYCLE * 5)
		en = 1'b1;
	 #(MAX_NUM * CYCLE * 500);
	 $stop;
end

distance_fare distance_fare_test (
.ten_meter_pulse			(ten_meter_pulse			),
.en							(en							),
.distance_fare_per_pulse	(distance_fare_per_pulse	),
.s_fare						(s_fare						),
	                   	
.distance_bcd				(distance_bcd				),
.distance_fare_bcd			(distance_fare_bcd			)
);

endmodule
