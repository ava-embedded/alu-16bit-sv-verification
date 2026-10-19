`ifndef VIF_IF_SV
`define VIF_IF_SV

interface vif_if (
    input logic clk_i
);

timeunit      1ns;
timeprecision 100ps;
parameter DataWidth = 16;

logic rst_i;
logic [DataWidth-1:0] x_i;
logic [DataWidth-1:0] y_i;
logic zx_i;
logic nx_i;
logic zy_i;
logic ny_i;
logic f_i;
logic no_i;
logic [DataWidth-1:0] out_o;
logic zr_o;
logic ng_o;
logic pos_o;

clocking cb @(posedge clk_i);
    default input #1ns output #1ns;

    output rst_i;
    output x_i;
    output y_i;
    output zx_i;
    output nx_i;
    output zy_i;
    output ny_i;
    output f_i;
    output no_i;

    input  out_o;
    input  zr_o;
    input  ng_o;
    input  pos_o;

endclocking

endinterface : vif_if

`endif // VIF_IF_SV