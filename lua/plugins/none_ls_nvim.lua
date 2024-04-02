return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local nls_diagnostics = nls.builtins.diagnostics
      local nls_formatting = nls.builtins.formatting
      local diagnostics = {
        -- The linter that needs to be added is loaded here
        nls_diagnostics.golangci_lint.with(require("plugins.extras.lsp.null-ls.diagnostics.golangci_lint")),
        nls_diagnostics.buf.with(require("plugins.extras.lsp.null-ls.diagnostics.buf")),
      }
      local formatting = {
        -- The formatter that needs to be added is loaded here
        nls_formatting.goimports.with(require("plugins.extras.lsp.null-ls.formatting.goimports")),
        nls_formatting.buf.with(require("plugins.extras.lsp.null-ls.formatting.buf")),
      }
      if type(opts.sources) == "table" then
        opts.sources = vim.list_extend(opts.sources, diagnostics)
        opts.sources = vim.list_extend(opts.sources, formatting)
      end

      -- builtins are loaded here
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
      opts.debug = true
    end,
  },
}
