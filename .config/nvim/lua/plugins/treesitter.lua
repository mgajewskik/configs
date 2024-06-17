return {
   {
      "tree-sitter-grammars/tree-sitter-hyprlang",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function(_, opts)
         -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#adding-parsers
         local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
         parser_config.hyprlang = {
            install_info = {
               url = "~/.local/share/nvim/lazy/tree-sitter-hyprlang", -- local path or git repo
               files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
               -- optional entries:
               branch = "main", -- default branch in case of git repo if different from master
               generate_requires_npm = false, -- if stand-alone parser without npm dependencies
               requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
            },
            filetype = "hyprlang", -- if filetype does not match the parser name
         }

         vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
         })
         vim.treesitter.language.register("hyprlang", "hyprlang")
      end,
   },
   {
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
         "nvim-treesitter/nvim-treesitter-textobjects",
         "RRethy/nvim-treesitter-endwise",
      },
      version = false,
      build = ":TSUpdate",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
         highlight = {
            enable = true, -- false will disable the whole extension
            -- disable = { "vim" }, -- list of language that will be disabled
            additional_vim_regex_highlighting = { "markdown" },
         },
         endwise = {
            enable = true,
         },
         indent = { enable = true },
         autopairs = { enable = true },
         rainbow = {
            enable = true,
            extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
            max_file_lines = 2000, -- Do not enable for files with more than specified lines
         },
         incremental_selection = {
            enable = false,
            keymaps = {
               init_selection = "<CR>",
               node_incremental = "<CR>",
               scope_incremental = "<S-CR>",
               node_decremental = "<BS>",
            },
         },
         -- should be in editor config but it can't
         textobjects = {
            select = {
               enable = true,
               -- Automatically jump forward to textobj, similar to targets.vim
               lookahead = true,
               keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                  ["al"] = "@loop.outer",
                  ["il"] = "@loop.inner",
                  ["ib"] = "@block.inner",
                  ["ab"] = "@block.outer",
                  ["ir"] = "@parameter.inner",
                  ["ar"] = "@parameter.outer",
               },
            },
         },
         ensure_installed = {
            "bash",
            "css",
            "cmake",
            "make",
            "dockerfile",
            "go",
            "gomod",
            "gowork",
            "proto",
            "hcl",
            "terraform",
            "html",
            "javascript",
            "typescript",
            "json",
            "latex",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "toml",
            "yaml",
            "rego",
            "comment",
            "diff",
            "gitcommit",
            "gitignore",
            "regex",
            "sql",
            "vim",
            "nix",
         }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      },
      config = function(_, opts)
         require("nvim-treesitter.configs").setup(opts)
         vim.treesitter.language.register("markdown", "octo")
      end,
   },
}
