require("flash").setup({

    continue = true,
    label = {
        -- allow uppercase labels
        uppercase = true,
        -- add any labels with the correct case here, that you want to exclude
        exclude = "",
        current = true,
        -- show the label after the match
        after = true, ---@type boolean|number[]
        -- show the label before the match
        before = false, ---@type boolean|number[]
        -- position of the label extmark
        style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
        -- flash tries to re-use labels that were already assigned to a position,
        -- when typing more characters. By default only lower-case labels are re-used.
        reuse = "lowercase", ---@type "lowercase" | "all" | "none"
        -- for the current window, label targets closer to the cursor first
        distance = true,
        -- minimum pattern length to show labels
        -- Ignored for custom labelers.
        min_pattern_length = 0,
        -- Enable this to use rainbow colors to highlight labels
        -- Can be useful for visualizing Treesitter ranges.
        rainbow = {
            enabled = true,
            shade = 5,
        },
        format = function(opts)
            return { { opts.match.label, opts.hl_group } }
        end,
    },
    modes = {
        -- options used when flash is activated through
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
            enabled = true,
            -- dynamic configuration for ftFT motions
            config = function(opts)
                -- autohide flash when in operator-pending mode
                opts.autohide = opts.autohide
                    or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

                -- disable jump labels when not enabled, when using a count,
                -- or when recording/executing registers
                opts.jump_labels = opts.jump_labels
                    and vim.v.count == 0
                    and vim.fn.reg_executing() == ""
                    and vim.fn.reg_recording() == ""
            end,
            autohide = true,
            jump_labels = true,
            multi_line = true,
            label = { exclude = "hjkliardc" },
            keys = { "f", "F", "t", "T", ";", "," },
            char_actions = function(motion)
                return {
                    [";"] = "next", -- set to `right` to always go right
                    [","] = "prev", -- set to `left` to always go left
                    -- clever-f style
                    [motion:lower()] = "next",
                    [motion:upper()] = "prev",
                }
            end,
            search = { wrap = false },
            highlight = { backdrop = true },
            jump = { register = false },
        },
    },
})
