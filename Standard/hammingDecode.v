`timescale 1ns / 1ps
module hammingDecode(
    input [6:0] data_in,
    output [2:0] syndrome
);

    wire [7:1] c;
    assign c = data_in;

    assign syndrome[0] = c[1] ^ c[3] ^ c[5] ^ c[7];
    assign syndrome[1] = c[2] ^ c[3] ^ c[6] ^ c[7];
    assign syndrome[2] = c[4] ^ c[5] ^ c[6] ^ c[7];
    
endmodule