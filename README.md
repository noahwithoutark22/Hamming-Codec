# Hamming-Codec
RTL code for a Hamming Error Correction Code (ECC) encoder and decoder. The repo includes a basic fixed-width module, plus a parameterized version for scalable integration. The encoder figures out parity bits on the fly ($2^p \ge m + p + 1$) and places them at power-of-two indices, while the decoder handles single-bit error detection and correction via syndrome decoding.
