{
  # Diagnostics

  "diagnostic.float" = "<cmd>lua vim.diagnostic.open_float()<cr>";
  "diagnostic.next" = "<cmd>lua vim.diagnostic.jump({ count = 1 })<cr>";
  "diagnostic.prev" = "<cmd>lua vim.diagnostic.jump({ count = -1 })<cr>";
  "diagnostic.loclist" = "<cmd>lua vim.diagnostic.setloclist()<cr>";

  # LSP

  "lsp.hover" = "<cmd>lua vim.lsp.buf.hover()<cr>";
  "lsp.definition" = "<cmd>lua vim.lsp.buf.definition()<cr>";
  "lsp.declaration" = "<cmd>lua vim.lsp.buf.declaration()<cr>";
  "lsp.implementation" = "<cmd>lua vim.lsp.buf.implementation()<cr>";
  "lsp.references" = "<cmd>lua vim.lsp.buf.references()<cr>";
  "lsp.rename" = "<cmd>lua vim.lsp.buf.rename()<cr>";
  "lsp.code-action" = "<cmd>lua vim.lsp.buf.code_action()<cr>";
  "lsp.signature" = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
  "lsp.format" = "<cmd>lua vim.lsp.buf.format({ async = true })<cr>";

  # Neo-tree

  "neo-tree.focus" = "<cmd>Neotree filesystem focus left<cr>";
  "neo-tree.toggle" = "<cmd>Neotree filesystem toggle left<cr>";
  "neo-tree.reveal" = "<cmd>Neotree filesystem reveal left<cr>";

  # Oil

  "oil.open" = "<cmd>Oil<cr>";

  # Telescope

  "telescope.find-files" = "<cmd>Telescope find_files<cr>";
  "telescope.live-grep" = "<cmd>Telescope live_grep<cr>";
  "telescope.buffers" = "<cmd>Telescope buffers<cr>";
  "telescope.help-tags" = "<cmd>Telescope help_tags<cr>";
  "telescope.git-files" = "<cmd>Telescope git_files<cr>";
  "telescope.diagnostics" = "<cmd>Telescope diagnostics<cr>";
  "telescope.lsp-references" = "<cmd>Telescope lsp_references<cr>";

  # Fzf-lua

  "fzf-lua.files" = "<cmd>FzfLua files<cr>";
  "fzf-lua.live-grep" = "<cmd>FzfLua live_grep<cr>";
  "fzf-lua.buffers" = "<cmd>FzfLua buffers<cr>";

  # Trouble

  "trouble.diagnostics" = "<cmd>Trouble diagnostics toggle<cr>";
  "trouble.symbols" = "<cmd>Trouble symbols toggle focus=false<cr>";
  "trouble.loclist" = "<cmd>Trouble loclist toggle<cr>";
  "trouble.quickfix" = "<cmd>Trouble qflist toggle<cr>";

  # Git

  "gitsigns.preview-hunk" = "<cmd>Gitsigns preview_hunk<cr>";
  "gitsigns.stage-hunk" = "<cmd>Gitsigns stage_hunk<cr>";
  "gitsigns.reset-hunk" = "<cmd>Gitsigns reset_hunk<cr>";
  "gitsigns.blame-line" = "<cmd>Gitsigns blame_line<cr>";
  "diffview.open" = "<cmd>DiffviewOpen<cr>";
  "diffview.close" = "<cmd>DiffviewClose<cr>";

  # Formatting

  "conform.format" = "<cmd>lua require('conform').format({ async = true, lsp_format = 'fallback' })<cr>";

  # DAP

  "dap.continue" = "<cmd>lua require('dap').continue()<cr>";
  "dap.toggle-breakpoint" = "<cmd>lua require('dap').toggle_breakpoint()<cr>";
  "dap.step-over" = "<cmd>lua require('dap').step_over()<cr>";
  "dap.step-into" = "<cmd>lua require('dap').step_into()<cr>";
  "dap.step-out" = "<cmd>lua require('dap').step_out()<cr>";
  "dap.repl" = "<cmd>lua require('dap').repl.open()<cr>";

  # Buffers / windows

  "buffer.next" = "<cmd>bnext<cr>";
  "buffer.prev" = "<cmd>bprevious<cr>";
  "buffer.close" = "<cmd>bdelete<cr>";
  "window.left" = "<C-w>h";
  "window.down" = "<C-w>j";
  "window.up" = "<C-w>k";
  "window.right" = "<C-w>l";
}
