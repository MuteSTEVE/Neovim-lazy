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
    config = function()
      require('config.colorscheme.onedark')
    end
  },

  -- Lsp, mason, lspsaga, lspconfig
  {
    {
      'kkharji/lspsaga.nvim',
      config = function()
        require('config.lsp.lspsaga')
      end
    },
    {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require('config.lsp.mason')
      end
    },
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('config.lsp.lspconfig')
      end
    },
    {
      'jose-elias-alvarez/null-ls.nvim',
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
    {
      'ults-io/vscode-react-javascript-snippets',
      build = 'yarn install --frozen-lockfile && yarn compile',
    },
    {
      'hrsh7th/nvim-cmp',
      config = function()
        require('config.snip.cmp')
      end
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require('config.snip.autopairs')
      end
    }
  },

  -- treesitter, ts-autotag, ts-rainbow2
  {
    'HiPhish/nvim-ts-rainbow2',
    'windwp/nvim-ts-autotag',
    'nvim-treesitter/nvim-treesitter-context',
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('config.treesitter')
      end
    },
  },

  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('config.ui.lualine')
    end
  },

  -- barbecue, navic
  {
    'utilyre/barbecue.nvim',
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
    config = function()
      require('config.ui.noice')
    end
  },

  -- nvim-tree, web-devicons
  {
    'nvim-tree/nvim-tree.lua',
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
    config = function()
      require('config.ui.bufferline')
    end
  },

  -- telescope
  {
    'nvim-telescope/telescope-file-browser.nvim',
    {
      'nvim-telescope/telescope.nvim',
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
    config = function()
      local status_ok, colorizer = pcall(require, 'colorizer')
      if not status_ok then
        return
      end

      colorizer.setup()
    end
  },

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('config.ui.gitsigns')
    end
  },

  -- indentline
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('config.ui.indentline')
    end
  },

  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('config.ui.toggleterm')
    end
  },

  {
    'terrortylor/nvim-comment',
    config = function()
      require('config.comment')
    end
  },

  {
    'folke/which-key.nvim',
    config = function()
      require('config.ui.whichkey')
    end
  },

  -- ZenMode, twilight
  {
    {
      'folke/zen-mode.nvim',
      config = function()
        require('config.ui.zenmode')
      end
    },

    {
      'folke/twilight.nvim',
      config = function()
        require('config.ui.twilight')
      end
    }
  },

  {
    'yamatsum/nvim-cursorline',
    config = function()
      require('config.cursorline')
    end
  },

  {
    'BlakeJC94/alpha-nvim-fortune',
    {
      'goolord/alpha-nvim', branch = 'feature/startify-fortune',
      config = function()
        require('config.ui.alpha')
      end
    }
  },

  {
    'ggandor/leap.nvim',
    config = function()
      local status_ok, leap = pcall(require, 'leap')
      if not status_ok then
        return
      end

      leap.add_default_mappings()
    end
  }

}

require("lazy").setup(plugins, opts)
