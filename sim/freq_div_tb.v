`timescale 1ns/1ns

module freq_div_tb();

reg clk;
reg en;
reg max;
reg rst_n;

wire min_pulse;


parameter CYCLE = 5'd20;
parameter MAX_NUM = 7'd100;

always # 10 clk = ~clk;

initial begin
    clk = 1'b0;
	 en = 1'b0;
	 max = 1'b0;
	 rst_n = 1'b0;
	 #(MAX_NUM * CYCLE * 5)
	 rst_n = 1'b1;
	 en = 1'b1;
	 #(MAX_NUM * CYCLE * 10);
	 max = 1'd1;
	 #(MAX_NUM * CYCLE * 10);
	 max = 1'd0;
	 #(MAX_NUM * CYCLE * 10);
	 rst_n = 1'b0;
	 #(MAX_NUM * CYCLE * 10);
	 rst_n = 1'b1;
	 #(MAX_NUM * CYCLE * 10);
	 $stop;
end

freq_div freq_div_test (
.clk		(clk		),
.rst_n		(rst_n		),
.en			(en			),
.max		(max		),
             
.min_pulse	(min_pulse	)
);

endmodule
