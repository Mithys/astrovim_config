local config = {

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      {
        "Mofiqul/dracula.nvim",
        as = "dracula",
        config = function()
          vim.cmd "colorscheme dracula"
        end,
       },
      {
        "phaazon/hop.nvim",
        branch = "v1", -- optional but strongly recommended
        config = function()
          -- you can configure Hop the way you like here; see :h hop-config
          require"hop".setup { keys = "dkslagheiruwoqptycvmxzbn" }
        end
      },
      {
        "tpope/vim-unimpaired"
      },
      {
        "bkad/CamelCaseMotion"
      },
      {
        "Saecki/crates.nvim",
        after = "nvim-cmp",
        config = function()
          require("crates").setup()

          local cmp = require "cmp"
          local config = cmp.get_config()
          table.insert(config.sources, { name = "crates" })
          cmp.setup(config)
        end,
      },
      {
        "machakann/vim-sandwich"
      },
      {
        "beauwilliams/focus.nvim",
        config = function()
          require("focus").setup({cursorline = false})
        end,
      },
    },

    -- All other entries override the setup() call for default plugins
    treesitter = {
      ensure_installed = { "lua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    },
    lualine = {
      options = {
        theme = 'dracula',
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_a = {'mode'},
      },
    },
  },

  ["which-key"] = {
    register_n_leader = {
      ["w"] = { "<cmd>HopWord<cr>", "Hop Word" },
      ["b"] = { "<cmd>HopWord<cr>", "Hop Word" },
      ["j"] = { "<cmd>HopLine<cr>", "Hop Line" },
      ["k"] = { "<cmd>HopLine<cr>", "Hop Line" },
      h = {
        name = "Focus",
        n = { "<cmd>FocusSplitNicely<cr>", "Split Nicely" },
        h = { "<cmd>FocusSplitLeft<cr>", "Split Left" },
        j = { "<cmd>FocusSplitDown<cr>", "Split Down" },
        k = { "<cmd>FocusSplitUp<cr>", "Split Up" },
        l = { "<cmd>FocusSplitRight<cr>", "Split Right" },
        e = { "<cmd>FocusEqualise<cr>", "Equalise" },
        m = { "<cmd>FocusMaximise<cr>", "Maximise" },
        t = { "<cmd>FocusToggle<cr>", "Toggle" },
      }
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- null-ls configuration
  ["null-ls"] = function()
    -- Formatting and linting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
      return
    end

    -- Check supported formatters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting

    -- Check supported linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
      debug = false,
      sources = {
        -- Set a formatter
        formatting.rufo,
        -- Set a linter
        diagnostics.rubocop,
      },
      -- NOTE: You can remove this on attach function to disable format on save
      on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
        end
      end,
    }
  end,
  
  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    local opts = { noremap = true, silent = true }
    local map = vim.api.nvim_set_keymap
    local set = vim.opt
    -- Set options
    set.relativenumber = false

    -- Set key bindings
    -- map("n", "<C-s>", "<cmd>w!<cr>", opts)
    map("n", "/", "<cmd>noh<cr>/", opts)

    map("", "<leader>w", "<cmd>HopWord<cr>", opts)
    map("", "<leader>b", "<cmd>HopWord<cr>", opts)
    map("", "<leader>j", "<cmd>HopLine<cr>", opts)
    map("", "<leader>k", "<cmd>HopLine<cr>", opts)

    map("", "f", "<cmd>HopChar1<cr>", opts)

    map("", "W", "<Plug>CamelCaseMotion_w", opts)
    map("", "B", "<Plug>CamelCaseMotion_b", opts)
    map("", "E", "<Plug>CamelCaseMotion_e", opts)

    map("n", "do", "ddO", opts)

    map("n", ",", "<cmd>FocusSplitCycle<cr>", opts)

    map("n", "<C-j>", "<C-d>", opts)

    -- Set autocommands
    vim.cmd [[
      augroup packer_conf
        autocmd!
        autocmd bufwritepost plugins.lua source <afile> | PackerSync
      augroup end
    ]]
  end,
}

return config
