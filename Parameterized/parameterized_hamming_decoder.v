`timescale 1ns / 1ps

module parameterized_hamming_decoder #(
    parameter DATA_WIDTH = 4,
    parameter PARITY_WIDTH = (DATA_WIDTH <= 4)? 3 : (DATA_WIDTH <= 11)? 4: (DATA_WIDTH <= 26)? 5: (DATA_WIDTH<=57)?6:7,
    parameter CODE_WIDTH = PARITY_WIDTH + DATA_WIDTH
)(
    input [CODE_WIDTH:1] hcode,
    output reg [PARITY_WIDTH-1:0] syndrome,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg error_det
);

    integer i,j;
    reg [CODE_WIDTH:1] corrected_code;
    always@(*) begin
        syndrome = 0;
        corrected_code = hcode;
        for(i=0; i<PARITY_WIDTH; i=i+1) begin
            for(j=1; j<=CODE_WIDTH; j=j+1) begin
                if((j & (1<<i))!=0) begin
                    syndrome[i] = syndrome[i] ^ hcode[j];
                end
            end
        end
        
        if(syndrome!=0) begin
        corrected_code[syndrome] = ~corrected_code[syndrome];
        error_det = 1'b1;
        end

        i=0;
        for(j=1;j<=CODE_WIDTH;j=j+1) begin
            if((j & (j-1))!=0) begin
                data_out[i] = corrected_code[j];
                i=i+1;
            end
        end
    end

endmodule