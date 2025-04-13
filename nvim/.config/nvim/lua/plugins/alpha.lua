return {
    {
        "goolord/alpha-nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local alpha = require("alpha")
            local theta = require("alpha.themes.theta")

            -- helper function for utf8 chars
            local function getCharLen(s, pos)
                local byte = string.byte(s, pos)
                if not byte then
                    return nil
                end
                return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
            end

            local function applyColors(logo, colors, logoColors)
                theta.header.val = logo

                for key, color in pairs(colors) do
                    local name = "Alpha" .. key
                    vim.api.nvim_set_hl(0, name, color)
                    colors[key] = name
                end

                theta.header.opts.hl = {}
                for i, line in ipairs(logoColors) do
                    local highlights = {}
                    local pos = 0

                    for j = 1, #line do
                        local opos = pos
                        pos = pos + getCharLen(logo[i], opos + 1)

                        local color_name = colors[line:sub(j, j)]
                        if color_name then
                            table.insert(highlights, { color_name, opos, pos })
                        end
                    end

                    table.insert(theta.header.opts.hl, highlights)
                end
            end

            applyColors({
                [[ ███    ██ ███████  ██████  ██    ██ ██ ███    ███ ]],
                [[ ████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ]],
                [[ ██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ]],
                [[ ██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ]],
                [[ ██   ████ ███████  ██████    ████   ██ ██      ██ ]],
                [[                                                   ]],
                [[                  N  E  O  V  I  M                 ]],
            }, {
                ["b"] = { fg = "#3399ff", ctermfg = 33 },
                ["a"] = { fg = "#53C670", ctermfg = 35 },
                ["g"] = { fg = "#39ac56", ctermfg = 29 },
                ["h"] = { fg = "#33994d", ctermfg = 23 },
                ["i"] = { fg = "#33994d", bg = "#39ac56", ctermfg = 23, ctermbg = 29 },
                ["j"] = { fg = "#53C670", bg = "#33994d", ctermfg = 35, ctermbg = 23 },
                ["k"] = { fg = "#30A572", ctermfg = 36 },
            }, {
                [[ aaa    aa aaaaaaa  aaaaaa  bb    bb bb bbb    bbb ]],
                [[ aaaa   aa aa      aa    aa bb    bb bb bbbb  bbbb ]],
                [[ aa aa  aa aaaaa   aa    aa bb    bb bb bb bbbb bb ]],
                [[ aa  aa aa aa      aa    aa  bb  bb  bb bb  bb  bb ]],
                [[ aa   aaaa aaaaaaa  aaaaaa    bbbb   bb bb      bb ]],
                [[                                                   ]],
                [[                  a  a  a  b  b  b                 ]],
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local count = (math.floor(stats.startuptime * 100) / 100)
                    local foot = "󱐋 " .. stats.loaded .. " plugins loaded in " .. count .. " ms"

                    local db = require("alpha.themes.dashboard")
                    theta.buttons.val = {
                        { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                        { type = "padding", val = 1 },
                        db.button("e", "  New file", "<cmd>ene<CR>"),
                        -- db.button("f", "󰈞  Find file"),
                        -- db.button("g", "󰊄  Live grep"),
                        db.button("c", "  Configuration", "<cmd>cd ~/.config/nvim/ <CR>"),
                        db.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
                        db.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
                        { type = "padding", val = 1 },
                        { type = "text", val = foot, opts = { hl = "Constant", position = "center" } },
                    }

                    pcall(vim.cmd.AlphaRedraw)
                end,
            })

            alpha.setup(theta.config)
        end,
    },
}
