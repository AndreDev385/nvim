return {
    config = function()
        local ls = require("luasnip")

        ls.config.set_config {
            history = false,
            updateevents = "TextChanged, TextChangedI",
        }

        -- load custom snippets
        for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("../snippets/*.lua", true)) do
            loadfile(ft_path)
        end

        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })
    end
}
