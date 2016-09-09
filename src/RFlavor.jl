module RFlavor

# package code goes here
import StatsBase, DataFrames
import StatsBase:IntegerVector, RealVector, IntegerMatrix, RealMatrix
import DataFrames.pool
import Base.show
export show

include("rep.jl")
include("table.jl")
end # module
