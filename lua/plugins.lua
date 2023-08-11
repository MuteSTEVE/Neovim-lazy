local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local opts = {}
local plugins = {

  -- Colorscheme
  {
    'navarasu/onedark.nvim',
    event = {
      "VimEnter",
      "GUIEnter",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.colorscheme.onedark')
    end
  },

  -- Lsp, mason, lspsaga, lspconfig
  {
    {
      'kkharji/lspsaga.nvim',
      event = {
        "VeryLazy",
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        require('config.lsp.lspsaga')
      end
    },
    {
      {
        'williamboman/mason.nvim',
        event = {
          "VeryLazy",
          "BufReadPost",
          "BufNewFile",
        },
        dependencies = {
          'williamboman/mason-lspconfig.nvim',
        },
        event = {
          "VeryLazy",
          "BufReadPost",
          "BufNewFile",
        },
        config = function()
          require('config.lsp.mason')
        end
      },
    },
    {
      'neovim/nvim-lspconfig',
      event = {
        "VeryLazy",
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        require('config.lsp.lspconfig')
      end
    },
    {
      'jose-elias-alvarez/null-ls.nvim',
      event = {
        "VeryLazy",
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        require('config.lsp.nulls')
      end
    }
  },

  -- cmp, vsnip, autopairs
  {
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
    event = {
      "VeryLazy",
      "InsertEnter",
      "BufReadPost",
      "BufNewFile",
    },
    {
      'ults-io/vscode-react-javascript-snippets',
      build = 'yarn install --frozen-lockfile && yarn compile',
      event = {
        "VeryLazy",
        "InsertEnter",
        "BufReadPost",
        "BufNewFile",
      },
    },
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
      },
      event = {
        "VeryLazy",
        "InsertEnter",
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        require('config.snip.cmp')
      end
    },
    {
      'windwp/nvim-autopairs',
      event = {
        "VeryLazy",
        "InsertEnter",
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        require('config.snip.autopairs')
      end
    }
  },

  -- treesitter, ts-autotag, ts-rainbow2
  {
    'windwp/nvim-ts-autotag',
    'nvim-treesitter/nvim-treesitter-context',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    {
      'HiPhish/nvim-ts-rainbow2',
      event = {
        "VeryLazy",
        "BufReadPost",
        "BufNewFile",
      },
    },
    {
      'nvim-treesitter/nvim-treesitter',
      event = {
        "VeryLazy",
        "BufReadPost",
        "BufNewFile",
      },
      build = ':TSUpdate',
      config = function()
        require('config.treesitter')
      end
    },
  },

  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.ui.lualine')
    end
  },

  -- barbecue, navic
  {
    'utilyre/barbecue.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    config = function()
      require('config.ui.barbecue')
    end
  },

  -- noice, nui, notify
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.ui.noice')
    end
  },

  -- nvim-tree, web-devicons
  {
    'nvim-tree/nvim-tree.lua',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('config.ui.nvimtree')
    end
  },

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.ui.bufferline')
    end
  },

  -- telescope
  {
    'nvim-telescope/telescope-file-browser.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    {
      'nvim-telescope/telescope.nvim',
      event = {
        "VeryLazy",
        "BufReadPost",
        "BufNewFile",
      },
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('config.ui.telescope')
      end
    },
  },

  -- colorizer
  {
    'norcalli/nvim-colorizer.lua',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    ft = {
      "css",
      "html",
      "php",
      "js",
    },
    config = function()
      require('config.colorizer')
    end
  },

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.ui.gitsigns')
    end
  },

  -- indentline
  {
    'lukas-reineke/indent-blankline.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.ui.indentline')
    end
  },

  {
    'akinsho/toggleterm.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.ui.toggleterm')
    end
  },

  {
    'terrortylor/nvim-comment',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.comment')
    end
  },

  {
    'folke/which-key.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.ui.whichkey')
    end
  },

  -- ZenMode, twilight
  {
    {
      'folke/zen-mode.nvim',
      event = {
        "VeryLazy",
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        require('config.ui.zenmode')
      end
    },

    {
      'folke/twilight.nvim',
      event = {
        "VeryLazy",
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        require('config.ui.twilight')
      end
    }
  },

  {
    'yamatsum/nvim-cursorline',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.cursorline')
    end
  },

  {
    'BlakeJC94/alpha-nvim-fortune',
    {
      'goolord/alpha-nvim',
      config = function()
        require('config.ui.alpha')
      end
    }
  },

  {
    'ggandor/leap.nvim',
    event = {
      "VeryLazy",
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require('config.leap')
    end
  }

}

require("lazy").setup(plugins, opts)
