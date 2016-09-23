using Documenter, RFlavor

makedocs(
    format = Documenter.Formats.HTML,
    sitename = "RFlavor.jl")

deploydocs(
    repo = "github.com/panlanfeng/RFlavor.jl.git",
    julia  = "0.5")
