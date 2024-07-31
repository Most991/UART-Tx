module UART(

input wire [7:0] p_data,
input wire data_valid,
input wire par_en,
input wire par_typ,
input wire clk,
input wire rst,
output wire TX_out,
output wire busy

);

wire ser_done;
wire ser_en;
wire [1:0] mux_sel;
wire ser_data;
wire par_bit;

serializer U1(
.p_data(p_data),
.data_valid(data_valid),
.clk(clk),
.rst(rst),
.ser_en(ser_en),
.ser_done(ser_done),
.ser_data(ser_data),
.busy(busy)
);

Mux U2(
.clk(clk),
.rst(rst),
.TX_out(TX_out),
.mux_sel(mux_sel),
.ser_data(ser_data),
.par_bit(par_bit)
);

Patity_Calc U3(
.p_data(p_data),
.data_valid(data_valid),
.par_typ(par_typ),
.clk(clk),
.rst(rst),
.par_bit(par_bit)
);

FSM U4(
.data_valid(data_valid),
.par_en(par_en),
.clk(clk),
.rst(rst),
.busy(busy),
.ser_done(ser_done),
.mux_sel(mux_sel),
.ser_en(ser_en)
);

endmodule