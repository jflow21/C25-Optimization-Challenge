using C25-Optimization-Challenge
using Documenter

DocMeta.setdocmeta!(C25-Optimization-Challenge, :DocTestSetup, :(using C25-Optimization-Challenge); recursive=true)

makedocs(;
    modules=[C25-Optimization-Challenge],
    authors="jacksonflowers <flowersj@mit.edu> and contributors",
    repo="https://github.com/jflow21/C25-Optimization-Challenge.jl/blob/{commit}{path}#{line}",
    sitename="C25-Optimization-Challenge.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jflow21.github.io/C25-Optimization-Challenge.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jflow21/C25-Optimization-Challenge.jl",
    devbranch="main",
)
