module RFlavor

# package code goes here
import Compat
import StatsBase, DataFrames
import StatsBase:IntegerVector, RealVector, IntegerMatrix, RealMatrix
import DataArrays:DataArray
import DataFrames:pool, DataFrame, Index
import Base.show
export show

export rep, table, asstring

include("rep.jl")
include("table.jl")
include("expandgrid.jl")
end # module
