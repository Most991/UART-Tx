`timescale 1ns/1ps

module UART_tb #(parameter CLK_Period = 10)();

reg [7:0] p_data;
reg data_valid;
reg par_en;
reg par_typ;
reg clk;
reg rst;
wire TX_out_reg;
wire busy;

always #(CLK_Period/2) clk = ~clk;

initial
begin
  $dumpfile("UART.vcd") ;       
  $dumpvars; 
  rst = 1'b1;
  clk = 1'b0;
  data_valid = 1'b0;
  par_en = 1'b1;
  par_typ = 1'b0; //even

  #CLK_Period
  rst = 1'b0;

  #CLK_Period
  rst = 1'b1; 

  #(1*CLK_Period)
  $display("Before data valid = 1");
  $display("idle--->",TX_out);
  $display("busy ",busy);
  
  #CLK_Period
  p_data = 8'b00110010; 
  data_valid = 1'b1;

  #CLK_Period
  data_valid = 1'b0;
  $display("Start bit---> ",TX_out);
  $display("busy ",busy);
  
  #CLK_Period
  $display("data bit 0---> ",TX_out);
  $display("busy ",busy);
  
  #CLK_Period
  $display("data bit 1---> ",TX_out);
  $display("busy ",busy);
  
  #CLK_Period

  $display("data bit 2---> ",TX_out);
  $display("busy ",busy);
  
  #CLK_Period

  $display("data bit 3---> ",TX_out);
  $display("busy ",busy);
  
  #CLK_Period
  $display("data bit 4---> ",TX_out);
  $display("busy ",busy);
  
  #CLK_Period

  $display("data bit 5---> ",TX_out);
  $display("busy ",busy);
  
  #CLK_Period

  $display("data bit 6---> ",TX_out);
  $display("busy ",busy); 
  
  #CLK_Period

  $display("data bit 7---> ",TX_out);
  $display("busy ",busy);
  
  #CLK_Period

  $display("Parity bit---> ",TX_out);
  $display("busy ",busy); 
  
  #CLK_Period
 
  $display("Stop bit---> ",TX_out);
  $display("busy ",busy); 
  
  #CLK_Period
  
  $display("idle---> ",TX_out);
  $display("busy ",busy); 
  
  #CLK_Period

  $display("idle---> ",TX_out);
  $display("busy ",busy); 
  #(10*CLK_Period)
  $stop;  
end



UART DUT (
.p_data(p_data),
.data_valid(data_valid),
.par_en(par_en),
.par_typ(par_typ),
.clk(clk),
.rst(rst),
.TX_out(TX_out),
.busy(busy)
);
endmodule
