`timescale 1ns / 1ps

module parameterized_hamming_encode #(
    parameter DATA_WIDTH = 4,
    parameter PARITY_WIDTH = (DATA_WIDTH <= 4) ? 3 : (DATA_WIDTH <= 11)? 4: (DATA_WIDTH <= 26)? 5: (DATA_WIDTH<=57)? 6: 7,
    parameter CODE_WIDTH = DATA_WIDTH + PARITY_WIDTH
)(
    input [DATA_WIDTH-1:0] data_in,
    output reg [CODE_WIDTH-1:0] code_out
);

    reg [CODE_WIDTH:1] code_int;
    integer i,j;
    reg [DATA_WIDTH-1:0] data_ptr;
    
    always @(*) begin
        data_ptr = data_in;
        for(i=1; i<=CODE_WIDTH; i=i+1) begin
            if( (i & (i-1))!=0) begin
                code_int[i] = data_ptr[0];
                data_ptr = data_ptr >> 1;
            end else begin
                code_int[i] = 1'b0;
            end
        end
        
        for(i=0; i<PARITY_WIDTH; i=i+1) begin
            for(j=1; j<=CODE_WIDTH; j=j+1) begin
                if(((j & (1<<i)) != 0) && (j!= (1<<i))) begin
                    code_int[1<<i] = code_int[1<<i] ^ code_int[j];
                end
            end
        end
        code_out = code_int;
    end
endmodule
