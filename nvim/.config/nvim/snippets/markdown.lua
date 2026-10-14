return {

    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "mdbathesis",
            dscr = "Note Template for BA Thesis",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta(
            [[
            ## General

            * Thema: TODO
            * Abgabedatum: TODO
            * Praktikumsbericht: TODO

            ## Meetings
            ]],
            {
            }
        )
        -- Table 3, the advanced snippet options, is left blank.
    ),

    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "mdmathesis",
            dscr = "Note Template for MA Thesis",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta(
            [[
            ## General

            * Thema: TODO
            * Abgabedatum: TODO
            * Zweitgutachter: TODO

            ## Meetings
            ]],
            {
            }
        )
        -- Table 3, the advanced snippet options, is left blank.
    ),

    require("luasnip").snippet(
        { -- Table 1: snippet parameters
            trig = "mdvortrag",
            dscr = "Note Template for a presentation",
            regTrig = false,
            priority = 1000,
            snippetType = "autosnippet",
        },
        fmta(
            [[
            ## Title

            * **Zeit**: TODO
            * **Note**: TODO

            ### Feedback

            ### Fragen
            ]],
            {
            }
        )
        -- Table 3, the advanced snippet options, is left blank.
    ),
}
