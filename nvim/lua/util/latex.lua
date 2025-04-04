local M = {}

local MATH_NODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
}

local ts_utils = require("nvim-treesitter.ts_utils")

M.in_env = function(env)
    local node = ts_utils.get_node_at_cursor()
    local bufnr = vim.api.nvim_get_current_buf()
    while node do
        if node:type() == "generic_environment" then
            local begin = node:child(0)
            local name = begin:field("name")
            if name[1] and vim.treesitter.get_node_text(name[1], bufnr, nil) == "{" .. env .. "}" then
                return true
            end
        end
        node = node:parent()
    end
    return false
end

M.in_text = function()
    local node = ts_utils.get_node_at_cursor()
    while node do
        if node:type() == "text_mode" then
            return true
        elseif MATH_NODES[node:type()] then
            return false
        end
        node = node:parent()
    end
    return true
end

M.in_mathzone = function()
    return not M.in_text()
end

M.in_item = function()
    return M.in_env("itemize") or M.in_env("enumerate")
end
M.in_tikz = function()
    return M.in_env("tikzpicture")
end
M.in_quantikz = function()
    return M.in_env("quantikz")
end

-- For markdown
M.in_latex = function()
    local node = ts_utils.get_node_at_cursor()
    while node do
        if node:type() == "latex_block" then
            print(true)
            return true
        end
        node = node:parent()
    end
    print(false)
    return false
end

M.clean = function()
    local current_dir = vim.fn.expand("%:p:h")
    local file_types = { "aux", "log", "out", "fls", "fdb_latexmk", "bcf", "run.xml", "toc", "DS_Store", "bak*", "dvi" }
    for _, file_type in ipairs(file_types) do
        local command = "rm " .. current_dir .. "/*." .. file_type
        vim.api.nvim_call_function("system", { command })
    end
end

M.sympy_calc = function()
    local selected_text = vim.fn.getreg("v")
    print(selected_text)
    vim.api.nvim_echo(selected_text, true, {})
end

return M
