module RFlavor

# package code goes here
import Compat
import StatsBase, DataFrames
import StatsBase:IntegerVector, RealVector, IntegerMatrix, RealMatrix
import DataFrames.pool
import Base.show
export show

export rep, table, asstring

include("rep.jl")
include("table.jl")
end # module
