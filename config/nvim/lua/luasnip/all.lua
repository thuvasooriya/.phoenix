return {
	s(
		"hi", -- LuaSnip expands this to {trig = "hi"}
		{ t("Hello, world!") }
	),
	-- Examples of Greek letter snippets, autotriggered for efficiency
	s({ trig = ";a", snippetType = "autosnippet" }, {
		t("\\alpha"),
	}),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		t("\\beta"),
	}),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		t("\\gamma"),
	}),
	-- \texttt
	s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" }, fmta("\\texttt{<>}", { i(1) })),
	-- \frac
	s(
		{ trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'" },
		fmt(
			"\\frac{<>}{<>}",
			{
				i(1),
				i(2),
			},
			{ delimiters = "<>" } -- manually specifying angle bracket delimiters
		)
	),
	-- Equation
	s(
		{ trig = "eq", dscr = "Expands 'eq' into an equation environment" },
		fmta(
			[[
       \begin{equation*}
           <>
       \end{equation*}
     ]],
			{ i(1) }
		)
	),
}
