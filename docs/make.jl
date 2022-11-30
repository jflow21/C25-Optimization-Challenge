using C25OptimizationChallenge
using Documenter

DocMeta.setdocmeta!(C25OptimizationChallenge, :DocTestSetup, :(using C25OptimizationChallenge); recursive=true)

makedocs(;
    modules=[C25OptimizationChallenge],
    authors="jacksonflowers <flowersj@mit.edu> and contributors",
    repo="https://github.com/jflow21/C25OptimizationChallenge.jl/blob/{commit}{path}#{line}",
    sitename="C25OptimizationChallenge.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jflow21.github.io/C25OptimizationChallenge.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jflow21/C25OptimizationChallenge.jl",
    devbranch="main",
)
