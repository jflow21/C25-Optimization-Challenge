using Test
using Aqua
using Documenter
using HashCode2014
using JuliaFormatter
using C25OptimizationChallenge

DocMeta.setdocmeta!(
    C25OptimizationChallenge,
    :DocTestSetup,
    :(using C25OptimizationChallenge);
    recursive=true,
)

@testset verbose = true "C25OptimizationChallenge.jl" begin
    @testset verbose = true "Code quality (Aqua.jl)" begin
        Aqua.test_all(C25OptimizationChallenge)
    end

    @testset verbose = true "Code quality (JuliaFormatter.jl)" begin
        JuliaFormatter.format(C25OptimizationChallenge)
    end

    @testset verbose = true "Code quality (Documenter.jl)" begin
        Documenter.doctest(C25OptimizationChallenge)
    end

    @testset verbose = true "Large instance" begin
        city = read_city()
        random_solution = random_walk(city)
        solution = breadth_first(city)
        @test is_feasible(solution, city)
        @test is_feasible(generate_solution(city, 2), city)
        @test total_distance(solution, city) >= total_distance(random_solution, city)
    end
end
