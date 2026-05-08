return {

    -- Example snippet for inline todonotes
    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "todotex",
            dscr = "A todonotes inline todo",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta("\\todo[inline]{<>}", { i(1) })
        -- Table 3, the advanced snippet options, is left blank.
    ),

    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "ttt",
            dscr = "A texttt command",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta("\\texttt{<>}", { i(1) })
        -- Table 3, the advanced snippet options, is left blank.
    ),

    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "tbf",
            dscr = "A textbf command",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta("\\textbf{<>}", { i(1) })
        -- Table 3, the advanced snippet options, is left blank.
    ),

    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "tit",
            dscr = "A textit command",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta("\\textit{<>}", { i(1) })
        -- Table 3, the advanced snippet options, is left blank.
    ),

    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "figtex",
            dscr = "A custom latex figure environment",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta(
            [[
            \begin{figure}[ht]
                \centering
                \includegraphics[width=0.95\textwidth]{<>}
                \caption{TODO}
                \label{fig:<>}
            \end{figure}
            ]],
            {
                i(1),
                i(2),
            }
        )
        -- Table 3, the advanced snippet options, is left blank.
    ),

    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "lsttex",
            dscr = "A custom latex lstinputlisting environment",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta(
            "\\lstinputlisting[language=C,caption=TODO,label=lst:<>]{<>}",
            {
                i(2),
                i(1),
            }
        )
        -- Table 3, the advanced snippet options, is left blank.
    ),
}
