`timescale 1ns/1ns

module bcd_adder_tb();

reg [3:0] a;
reg [3:0] b;
reg c_in;

wire [3:0] sum;
wire c_out;

parameter CYCLE = 5'd20;
always #10 a = (sum==4'd9) ? 4'b0 : sum + 1'd1;



initial begin
		a = 4'b0000;
		b = 4'b0000;
		c_in = 1'b0;
	#(CYCLE * 50);
	$stop;
end


bcd_adder bcd_adder_test (
.a			(a		), 
.b			(b		),
.c_in		(c_in	),
          
.sum		(sum	),
.c_out		(c_out	) 				
);

endmodule
