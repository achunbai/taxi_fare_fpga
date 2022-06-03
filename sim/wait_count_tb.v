`timescale 1ns/1ns

module wait_count_tb();

reg min_pulse;
reg rst_n;

wire wait_fare_pulse;


parameter CYCLE = 5'd20;
parameter MAX_NUM = 7'd100;

always # 10 min_pulse = ~min_pulse;

initial begin
    min_pulse = 1'b0;
	 min_pulse = 1'b0;
	 rst_n = 1'b0;
	 #(MAX_NUM * CYCLE * 5)
	 rst_n = 1'b1;
	 #(MAX_NUM * CYCLE * 50);
	 $stop;
end

wait_count wait_count_test (
.min_pulse		(min_pulse		),
.rst_n			(rst_n			),
                
.wait_fare_pulse(wait_fare_pulse)
);

endmodule
