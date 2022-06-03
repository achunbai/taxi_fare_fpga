`timescale 1ns/1ns

module taxi_fare_tb();

reg         clk;
reg         rst_n;
reg         en;
reg 		wait_en;
reg [11:0]  distance_fare_per_pulse;
reg [11:0]  s_fare;
reg         ten_meter_pulse;
reg [11:0]  wait_fare_per_unit;
wire [7:0]  fare_a;
wire [7:0]  fare_b;
wire [7:0]  fare_c;
wire [7:0]  fare_d;
wire [7:0]  distance_a;
wire [7:0]  distance_b;

parameter CYCLE = 5'd20;
parameter MAX_NUM = 7'd100;
parameter MIN_COUNT = 4'd10;
parameter WAIT_COUNT = 3'd5;

always # 10 clk = ~clk;
//always # 500_000_000 ten_meter_pulse = ~ten_meter_pulse;
always # 50 ten_meter_pulse = ~ten_meter_pulse;

initial begin
    clk = 1'b0;
	 wait_en = 1'd0;
	 ten_meter_pulse = 1'b0;
	 wait_fare_per_unit = 12'b0000_0101_0000;
	 rst_n = 1'b0;
	 en = 1'b0;
	 distance_fare_per_pulse = 12'b0000_0000_0011;
	 s_fare = 12'b0011_0000_0000;
	 #(CYCLE)
	 rst_n = 1'b1;
	 en = 1'b1;
	 #(MAX_NUM * CYCLE * 100);
	 wait_en = 1'b1;
	 #(MAX_NUM * CYCLE * 100);
	 wait_en = 1'b0;
	 #(MAX_NUM * CYCLE * 200);
	 $stop;
end

taxi_fare#(
	.MIN_COUNT	(MIN_COUNT	),
	.WAIT_COUNT	(WAIT_COUNT	)
) u_taxi_fare(
.clk						(clk						),
.rst_n						(rst_n						),
.en							(en							),
.wait_en					(wait_en					),
.distance_fare_per_pulse	(distance_fare_per_pulse	),
.s_fare						(s_fare						),
.ten_meter_pulse			(ten_meter_pulse			),
.wait_fare_per_unit			(wait_fare_per_unit			),

.fare_a			(fare_a			),
.fare_b			(fare_b			),
.fare_c			(fare_c			),
.fare_d			(fare_d			),
.distance_a		(distance_a		),
.distance_b		(distance_b		)
);

endmodule
