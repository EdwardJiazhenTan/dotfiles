-- ~/.config/nvim/lua/plugins/snippets.lua
return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node

      -- LuaSnip 基础配置
      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- 加载预制片段
      require("luasnip.loaders.from_vscode").lazy_load()

      -- 工具函数
      local function capitalize(text)
        return text:sub(1, 1):upper() .. text:sub(2)
      end

      -- 创建动态React组件片段
      local function create_react_component()
        return s("reactc", {
          t("import React from 'react';"),
          t({ "", "" }),
          t("interface "),
          i(1, "ComponentName"),
          t("Props {"),
          t({ "", "  " }),
          i(2, "// Define props here"),
          t({ "", "}" }),
          t({ "", "" }),
          t("const "),
          f(function(args) return args[1][1] end, { 1 }),
          t(": React.FC<"),
          f(function(args) return args[1][1] end, { 1 }),
          t("Props> = ("),
          i(3, "props"),
          t(") => {"),
          t({ "", "  return (" }),
          t({ "", "    " }),
          i(0),
          t({ "", "  );" }),
          t({ "", "};" }),
          t({ "", "" }),
          t("export default "),
          f(function(args) return args[1][1] end, { 1 }),
          t(";"),
        })
      end

      -- 创建动态Hook片段
      local function create_usestate()
        return s("ustate", {
          t("const ["),
          i(1, "state"),
          t(", set"),
          f(function(args) return capitalize(args[1][1]) end, { 1 }),
          t("] = useState"),
          c(2, {
            t(""),
            t("<string>"),
            t("<number>"),
            t("<boolean>"),
            t("<any>"),
          }),
          t("("),
          i(0, "initialValue"),
          t(");"),
        })
      end

      local function create_useeffect()
        return s("ueffect", {
          t("// "),
          i(1, "Effect"),
          t(" effect"),
          t({ "", "useEffect(() => {" }),
          t({ "", "  " }),
          i(2, "// Effect logic"),
          t({ "", "}, [" }),
          i(0, "dependencies"),
          t("]);"),
        })
      end

      local function create_handle()
        return s("handleevent", {
          t("const handle"),
          i(1, "Event"),
          t(" = ("),
          c(2, {
            t(""),
            t("event: React.MouseEvent"),
            t("event: React.ChangeEvent<HTMLInputElement>"),
            t("event: React.FormEvent"),
          }),
          t(") => {"),
          t({ "", "  " }),
          i(0, "// Handle logic"),
          t({ "", "};" }),
        })
      end

      -- React TypeScript 片段
      ls.add_snippets("typescriptreact", {
        -- 简单易用的片段
        create_react_component(),
        create_usestate(),
        create_useeffect(),
        create_handle(),

        -- useCallback
        s("ucallback", {
          t("const "),
          i(1, "callback"),
          t(" = useCallback(("),
          i(2, "params"),
          t(") => {"),
          t({ "", "  " }),
          i(3, "// Callback logic"),
          t({ "", "}, [" }),
          i(0, "dependencies"),
          t("]);"),
        }),

        -- useMemo
        s("umemo", {
          t("const "),
          i(1, "memoValue"),
          t(" = useMemo(() => {"),
          t({ "", "  " }),
          i(2, "// Expensive calculation"),
          t({ "", "}, [" }),
          i(0, "dependencies"),
          t("]);"),
        }),

        -- useRef
        s("uref", {
          t("const "),
          i(1, "ref"),
          t(" = useRef"),
          c(2, {
            t(""),
            t("<HTMLDivElement>"),
            t("<HTMLInputElement>"),
            t("<HTMLButtonElement>"),
            t("<any>"),
          }),
          t("("),
          i(0, "null"),
          t(");"),
        }),

        -- useContext
        s("ucontext", {
          t("const "),
          i(1, "context"),
          t(" = useContext("),
          i(2, "Context"),
          t(");"),
        }),

        -- 预定义常用页面
        s("loginpage", {
          t("import React from 'react';"),
          t({ "", "" }),
          t("interface LoginProps {"),
          t({ "", "  " }),
          i(1, "// Define props here"),
          t({ "", "}" }),
          t({ "", "" }),
          t("const Login: React.FC<LoginProps> = (props) => {"),
          t({ "", "  return (" }),
          t({ "", "    " }),
          i(0),
          t({ "", "  );" }),
          t({ "", "};" }),
          t({ "", "" }),
          t("export default Login;"),
        }),

        s("homepage", {
          t("import React from 'react';"),
          t({ "", "" }),
          t("interface HomeProps {"),
          t({ "", "  " }),
          i(1, "// Define props here"),
          t({ "", "}" }),
          t({ "", "" }),
          t("const Home: React.FC<HomeProps> = (props) => {"),
          t({ "", "  return (" }),
          t({ "", "    " }),
          i(0),
          t({ "", "  );" }),
          t({ "", "};" }),
          t({ "", "" }),
          t("export default Home;"),
        }),

        s("dashboardpage", {
          t("import React from 'react';"),
          t({ "", "" }),
          t("interface DashboardProps {"),
          t({ "", "  " }),
          i(1, "// Define props here"),
          t({ "", "}" }),
          t({ "", "" }),
          t("const Dashboard: React.FC<DashboardProps> = (props) => {"),
          t({ "", "  return (" }),
          t({ "", "    " }),
          i(0),
          t({ "", "  );" }),
          t({ "", "};" }),
          t({ "", "" }),
          t("export default Dashboard;"),
        }),

        -- 原来的简单片段
        s("rfc", {
          t("import React from 'react';"),
          t({ "", "" }),
          t("const Component = () => {"),
          t({ "", "  return (" }),
          t({ "", "    " }),
          i(1, "Hello World"),
          t({ "", "  );" }),
          t({ "", "};" }),
          t({ "", "" }),
          t("export default Component;"),
        }),

        s("rafce", {
          t("import React from 'react';"),
          t({ "", "" }),
          t("interface Props {"),
          t({ "", "  " }),
          i(1, "// Define props here"),
          t({ "", "}" }),
          t({ "", "" }),
          t("const Component: React.FC<Props> = ("),
          i(2, "props"),
          t(") => {"),
          t({ "", "  return (" }),
          t({ "", "    " }),
          i(0, "Content"),
          t({ "", "  );" }),
          t({ "", "};" }),
          t({ "", "" }),
          t("export default Component;"),
        }),

        -- 其他常用片段
        s("cl", {
          t("console.log("),
          i(1, "message"),
          t(");"),
        }),

        s("map", {
          i(1, "items"),
          t(".map(("),
          i(2, "item"),
          t(", "),
          i(3, "index"),
          t(") => ("),
          t({ "", "  <div key={" }),
          c(4, {
            i(nil, "index"),
            i(nil, "item.id"),
          }),
          t("}>"),
          t({ "", "    " }),
          i(0, "content"),
          t({ "", "  </div>" }),
          t({ "", "));" }),
        }),

        s("tern", {
          i(1, "condition"),
          t(" ? "),
          i(2, "trueValue"),
          t(" : "),
          i(3, "falseValue"),
        }),

        -- Import 片段
        s("imr", {
          t("import React from 'react';"),
        }),

        s("imus", {
          t("import React, { useState } from 'react';"),
        }),

        s("imue", {
          t("import React, { useEffect } from 'react';"),
        }),
      })

      -- 设置快捷键
      local opts = { silent = true }

      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          return "<Tab>"
        end
      end, vim.tbl_extend("force", opts, { expr = true }))

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        else
          return "<S-Tab>"
        end
      end, vim.tbl_extend("force", opts, { expr = true }))

      vim.keymap.set("i", "<C-L>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, opts)

      vim.keymap.set("n", "<leader>se", function()
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/plugins/snippets.lua" })
        print("Snippets reloaded!")
      end, { desc = "Reload snippets" })
    end,
  },
}

--[[
=================================================================================
                        LuaSnip 快捷键和片段说明 (简化版本)
=================================================================================

🎯 基本键位：
Tab              - 展开片段 / 下一个插入点
Shift + Tab      - 上一个插入点
Ctrl + L         - 切换选择项（类型选择等）
<leader>se       - 重新加载片段

🚀 React 片段：
reactc           - 自定义React组件 (输入组件名)
ustate           - useState (输入状态名)
ueffect          - useEffect (输入效果描述)
ucallback        - useCallback
umemo            - useMemo
uref             - useRef
ucontext         - useContext
handleevent      - 事件处理函数

📦 预定义页面：
loginpage        - Login 页面组件
homepage         - Home 页面组件
dashboardpage    - Dashboard 页面组件

📦 基础片段：
rfc/rafce        - 函数组件
cl               - console.log
map/tern         - 数组渲染/三元运算符
imr/imus/imue    - React 导入

💡 使用：输入片段名 + Tab → 填写内容 → Tab 跳转 → 完成
💡 return() 现在是空的，可以直接在里面填写JSX内容
=================================================================================
]]
