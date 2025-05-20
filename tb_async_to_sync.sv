module tb_async_to_sync;

    // Declare testbench signals
    logic outclk;
    logic async_sig;
    logic out_sync_sig;

    // Instantiate DUT
    async_to_sync dut (
        .outclk(outclk),
        .async_sig(async_sig),
        .out_sync_sig(out_sync_sig)
    );

    // Generate clock (10ns period = 100MHz)
    initial outclk = 0;
    always #5 outclk = ~outclk;

    // Test sequence
    initial begin
        // Initial state
        async_sig = 0;

        // Wait some time, then toggle async_sig
        #12 async_sig = 1; // async input asserted
        #17 async_sig = 0; // async input deasserted
        #10 async_sig = 1;
        #13 async_sig = 0;
        #30 async_sig = 1;
        #7  async_sig = 0;
        #50;
        $finish;
    end
endmodule
