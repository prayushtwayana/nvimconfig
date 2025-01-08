-- Bootstrap lazy.nvim (the find filespackage manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy.nvim
require("lazy").setup({
    -- colorscheme
    { "catppuccin/nvim",  name = "catppuccin", priority = 1000 },
    { "rose-pine/neovim", name = "rose-pine" },

    -------------------------------------------------------------------------------------

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -------------------------------------------------------------------------------------

    -- treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/playground' },

    -------------------------------------------------------------------------------------

    -- harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -------------------------------------------------------------------------------------

    -- undo tree
    {
        'mbbill/undotree',
    },

    -------------------------------------------------------------------------------------

    -- git integration
    {
      'tpope/vim-fugitive',
    },

    -------------------------------------------------------------------------------------

    -- lsp
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },

    -------------------------------------------------------------------------------------

    -- mason
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },

    -------------------------------------------------------------------------------------

    -- completion
    {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp"
        }
    },
    { 'hrsh7th/nvim-cmp' },
})
