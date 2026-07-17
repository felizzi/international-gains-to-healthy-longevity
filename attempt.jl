cd("C://Users//zilef//OneDrive//Documents//Longevity_Scott//international-gains-to-healthy-longevity")
#end

using Statistics, Parameters, DataFrames
using QuadGK, NLsolve, Roots, FiniteDifferences, Interpolations
using Plots, XLSX, ProgressMeter, Formatting, TableView, Latexify, LaTeXStrings

# Import functions
include("src/TargetingAging.jl")


bio_pars = BiologicalParameters()

bio_pars.δ
bio_pars.γ 
bio_pars.μ
bio_pars.ξ
bio_pars.ϕ
bio_pars.ψ

print