`timescale 1ns / 1ps
module hammingCode (
    input [3:0] data_in,
    output [6:0] hcode
);
    wire [7:1] c;

    assign c[3] = data_in[0];
    assign c[5] = data_in[1];
    assign c[6] = data_in[2];
    assign c[7] = data_in[3];

    assign c[1] = c[3] ^ c[5] ^ c[7];
    assign c[2] = c[3] ^ c[6] ^ c[7];
    assign c[4] = c[5] ^ c[6] ^ c[7];

    assign hcode = c;
    
endmodule
