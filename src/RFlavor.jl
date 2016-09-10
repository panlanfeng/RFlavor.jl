module RFlavor

# package code goes here
import Compat
import StatsBase, DataFrames
import StatsBase:IntegerVector, RealVector, IntegerMatrix, RealMatrix
import DataArrays:DataArray, PooledDataArray
import DataFrames:pool, DataFrame, Index
import Base.show
export show
import Base.isempty
export isempty

export rep, table, asstring

include("rep.jl")
include("table.jl")
include("expandgrid.jl")
include("headtail.jl")
include("is.jl")
include("range.jl")
include("dim.jl")
end # module
