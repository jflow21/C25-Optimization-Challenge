using Optimization Challenge
using Documenter

DocMeta.setdocmeta!(Optimization Challenge, :DocTestSetup, :(using Optimization Challenge); recursive=true)

makedocs(;
    modules=[Optimization Challenge],
    authors="jacksonflowers <flowersj@mit.edu> and contributors",
    repo="https://github.com/jflow21/Optimization Challenge.jl/blob/{commit}{path}#{line}",
    sitename="Optimization Challenge.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jflow21.github.io/Optimization Challenge.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jflow21/Optimization Challenge.jl",
    devbranch="main",
)
