module fdc (input logic clk, input logic clr, input logic d, output logic q);
    always_ff@(posedge clk, posedge clr)
        if (clr)
            q <= 1'b0;
        else
            q <= d;
endmodule

module async_to_sync (input logic outclk, input logic async_sig, output logic out_sync_sig);
    logic fdc_1_out, q1, q2, vcc, clr;
    assign vcc = 1'b1;
    assign clr = 1'b0;

    always_ff@(negedge outclk, posedge clr)
        if (clr)
            fdc_1_out <= 1'b0;
        else
            fdc_1_out <= out_sync_sig;

    fdc f1 (.clk(async_sig), .clr(fdc_1_out), .d(vcc), .q(q1));
    fdc f2 (.clk(outclk), .clr(clr), .d(q1), .q(q2));
    fdc f3 (.clk(outclk), .clr(clr), .d(q2), .q(out_sync_sig));
endmodule
