/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_asiclab_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output reg [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // All output pins must be assigned. If not used, assign to 0.
    assign uio_out = 0;
    assign uio_oe   = 0;

    // Synchronous logic for uo_out
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin // Active low reset
            uo_out <= 8'b0;
        end else begin
            // Sum of upper and lower nibbles of ui_in, assigned to the lower nibble of uo_out
            uo_out[3:0] <= ui_in[7:4] + ui_in[3:0];
            uo_out[7:4] <= 4'b0; // Assign upper nibble of uo_out to 0
        end
    end

    // List all unused inputs to prevent warnings
    // It's good practice to list all genuinely unused inputs.
    // For `ena`, `uio_in`, if not used in the final logic, they can be included here.
    wire _unused_ena = ena;
    wire _unused_uio_in = uio_in;
    // clk and rst_n are used in the always block, so they are not unused.
    // ui_in is used in the always block, so it is not unused.

endmodule
