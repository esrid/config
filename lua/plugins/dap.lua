return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'leoluz/nvim-dap-go', 
        'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
        {
            '<leader>dc',
            function()
                require('dap').continue()
            end,
            desc = 'Debug: Start/Continue',
        },
        {
            '<leader>db',
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = 'Debug: Toggle Breakpoint',
        },
        {
            '<leader>dB',
            function()
                require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end,
            desc = 'Debug: Conditional Breakpoint',
        },
        {
            '<leader>dt',
            function()
                require('dap').terminate()
            end,
            desc = 'Debug: Terminate',
        },
        {
            '<leader>dr',
            function()
                require('dap').repl.toggle()
            end,
            desc = 'Debug: Toggle REPL',
        },
        {
            '<leader>dl',
            function()
                require('dap').run_last()
            end,
            desc = 'Debug: Run Last',
        },
        {
            '<leader>di',
            function()
                require('dap').step_into()
            end,
            desc = 'Debug: Step Into',
        },
        {
            '<leader>do',
            function()
                require('dap').step_over()
            end,
            desc = 'Debug: Step Over',
        },
        {
            '<leader>dO',
            function()
                require('dap').step_out()
            end,
            desc = 'Debug: Step Out',
        },
        {
            '<leader>du',
            function()
                require('dapui').toggle()
            end,
            desc = 'Debug: Toggle UI',
        },
        {
            '<leader>de',
            function()
                require('dapui').eval()
            end,
            mode = {'n', 'v'},
            desc = 'Debug: Evaluate Expression',
        },
        {
            '<leader>dh',
            function()
                require('dap.ui.widgets').hover()
            end,
            desc = 'Debug: Hover',
        },
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        
        -- Premium DAP UI setup with modern aesthetic
        dapui.setup({
            icons = { 
                expanded = '󰅀', 
                collapsed = '󰅂', 
                current_frame = '󰁔' 
            },
            mappings = {
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            element_mappings = {},
            expand_lines = true,
            force_buffers = true,
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.40 },
                        { id = "breakpoints", size = 0.15 },
                        { id = "stacks", size = 0.30 },
                        { id = "watches", size = 0.15 },
                    },
                    size = 55,
                    position = "left",
                },
                {
                    elements = {
                        { id = "repl", size = 0.55 },
                        { id = "console", size = 0.45 },
                    },
                    size = 16,
                    position = "bottom",
                },
            },
            controls = {
                enabled = true,
                element = "repl",
                icons = {
                    pause = '󰏤',
                    play = '󰐊',
                    step_into = '󰆹',
                    step_over = '󰆸',
                    step_out = '󰆷',
                    step_back = '󰜺',
                    run_last = '󰑙',
                    terminate = '󰓛',
                    disconnect = '󰋑',
                },
            },
            floating = {
                max_height = 0.85,
                max_width = 0.85,
                border = "rounded",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 2 },
            render = {
                max_type_length = 50,
                max_value_lines = 200,
                indent = 2,
            },
        })
        
        -- Smooth animations and better visual feedback
        dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
            vim.notify('󰃤 Debugger Started', vim.log.levels.INFO)
        end
        
        dap.listeners.before.event_terminated['dapui_config'] = function()
            vim.notify('󰓛 Debugger Terminated', vim.log.levels.WARN)
            dapui.close()
        end
        
        dap.listeners.before.event_exited['dapui_config'] = function()
            vim.notify('󰗼 Debugger Exited', vim.log.levels.INFO)
            dapui.close()
        end
        
        -- Enhanced virtual text with modern styling
        require("nvim-dap-virtual-text").setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            clear_on_continue = false,
            display_callback = function(variable, buf, stackframe, node, options)
                local value = variable.value:gsub("%s+", " ")
                if #value > 80 then
                    value = value:sub(1, 77) .. "..."
                end
                if options.virt_text_pos == 'inline' then
                    return ' 󰁔 ' .. value
                else
                    return '  ' .. variable.name .. ' 󰁔 ' .. value
                end
            end,
            virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil
        })
        
        -- Setup dap-go with optimizations
        require('dap-go').setup({
            delve = {
                path = "dlv",
                initialize_timeout_sec = 20,
                port = "${port}",
                detached = true,
            },
        })
        
        -- Beautiful breakpoint signs with nerd font icons
        vim.fn.sign_define('DapBreakpoint', { 
            text = '', 
            texthl = 'DiagnosticError', 
            linehl = '', 
            numhl = 'DiagnosticError' 
        })
        vim.fn.sign_define('DapBreakpointCondition', { 
            text = '', 
            texthl = 'DiagnosticWarn', 
            linehl = '', 
            numhl = 'DiagnosticWarn' 
        })
        vim.fn.sign_define('DapBreakpointRejected', { 
            text = '', 
            texthl = 'DiagnosticHint', 
            linehl = '', 
            numhl = 'DiagnosticHint' 
        })
        vim.fn.sign_define('DapLogPoint', { 
            text = '', 
            texthl = 'DiagnosticInfo', 
            linehl = '', 
            numhl = 'DiagnosticInfo' 
        })
        vim.fn.sign_define('DapStopped', { 
            text = '󰁔', 
            texthl = 'DiagnosticOk', 
            linehl = 'DapStoppedLine', 
            numhl = 'DiagnosticOk' 
        })
        
        -- Custom highlight groups for better visuals
        vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2d3640' })
        vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e06c75' })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })
        vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })
        
        -- Enhanced error handling with notifications
        dap.listeners.after.event_output['custom_output'] = function(session, body)
            if body.category == 'stderr' then
                vim.notify('󰃤 ' .. body.output, vim.log.levels.ERROR, {
                    title = "DAP Error",
                    timeout = 5000,
                })
            elseif body.category == 'console' then
                -- Optionally show console output
                -- vim.notify(body.output, vim.log.levels.INFO)
            end
        end
        
        -- Set up DAP UI window options with premium styling
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "dapui_*",
            callback = function()
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = true
                vim.opt_local.breakindent = true
                vim.opt_local.showbreak = "↪ "
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.signcolumn = "no"
                vim.opt_local.foldcolumn = "0"
                vim.opt_local.scrolloff = 3
                vim.opt_local.conceallevel = 0
            end,
        })
        
        -- Enhanced REPL experience with proper wrapping
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "dap-repl",
            callback = function()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = true
                vim.opt_local.breakindent = true
                vim.opt_local.showbreak = "  "
                vim.opt_local.textwidth = 0
                vim.opt_local.wrapmargin = 0
            end,
        })
        
        -- Console output formatting
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*dapui_console*",
            callback = function()
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = false  -- Don't use linebreak for JSON
                vim.opt_local.breakindent = true
                vim.opt_local.breakindentopt = "shift:2"
                vim.opt_local.showbreak = "  ⤷ "
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
            end,
        })
        
        -- Add custom commands for better workflow
        vim.api.nvim_create_user_command('DapUIToggle', function()
            require('dapui').toggle()
        end, {})
        
        vim.api.nvim_create_user_command('DapUIOpen', function()
            require('dapui').open()
        end, {})
        
        vim.api.nvim_create_user_command('DapUIClose', function()
            require('dapui').close()
        end, {})
        
        -- Conditional breakpoint with better UX
        vim.api.nvim_create_user_command('DapConditionalBreakpoint', function()
            local condition = vim.fn.input('Breakpoint condition: ')
            if condition ~= '' then
                require('dap').set_breakpoint(condition)
                vim.notify('󰃤 Conditional breakpoint set: ' .. condition, vim.log.levels.INFO)
            end
        end, {})
    end,
}
