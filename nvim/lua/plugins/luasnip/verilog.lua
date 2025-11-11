local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    -- fsm template
    -- s(
    --     { trig = ";fsm", snippetType = "autosnippet" },
    --     fmta(
    --         [[
    -- localparam S_IDLE = 2'd0;
    -- localparam S_RUN = 2'd1;
    -- localparam S_DONE = 2'd2;
    --
    -- reg [1:0] cur_state, next_state;
    --
    -- // state transition
    -- always @(posedge clk or negedge rst_n) begin
    --   if (!rst_n) begin
    --     cur_state <= S_IDLE;
    --   end else begin
    --     cur_state <= next_state;
    --   end
    -- end
    --
    -- // transtion condition
    -- always_comb begin
    --   case (cur_state)
    --     S_IDLE: begin
    --       if (idle2run_start) begin
    --         next_state = S_RUN;
    --       end else begin
    --         next_state = state;
    --       end
    --     end
    --     S_RUN: begin
    --       if (run2done_start) begin
    --         next_state = S_DONE;
    --       end else begin
    --         next_state = state;
    --       end
    --     end
    --     S_DONE: begin
    --       if (done2idle_start) begin
    --         next_state = S_IDLE;
    --       end else begin
    --         next_state = state;
    --       end
    --     end
    --     default: begin
    --       next_state = S_IDLE;
    --     end
    --   endcase
    -- end
    --
    -- // transtion condition
    -- wire idle2run_start = cur_state == S_IDLE && ;
    -- wire run2done_start = cur_state == S_RUN && ;
    -- wire done2idle_start = cur_state == S_DONE && ;
    --
    -- // output (1 signal => 1 always)
    -- always @(posedge clk or negedge rst_n) begin
    --   if (!rst_n) begin
    --     out1 <= 1'b0;
    --   end else if(cur_state == S_RUN) begin
    --     out1 <= 1'b1;
    --   end else begin
    --     out1 <= 1'b0;
    --   end
    -- end


    --     ]],
    --         {}
    --     ),
    --     { condition = line_begin }
    -- ),

    -- counter template
    -- s(
    --     { trig = ";fsm", snippetType = "autosnippet" },
    --     fmta(
    --         [[

    -- wire add_cnt = ;
    -- wire end_cnt =  add_cnt && cnt == x-1;
    --
    -- always @(posedge clk or negedge rst_n) begin
    --   if (!rst_n) begin
    --     cnt <= 0;
    --   end else if (add_cnt) begin
    --     if (end_cnt) cnt <= 0;
    --     else cnt <= cnt + 1;
    --   end
    -- end

    --     ]],
    --         {}
    --     ),
    --     { condition = line_begin }
    -- ),
}
