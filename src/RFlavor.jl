module RFlavor

# package code goes here
using Compat
import StatsBase, DataFrames
import StatsBase:IntegerVector, RealVector, IntegerMatrix, RealMatrix
import DataArrays:DataArray, PooledDataArray
import DataFrames:pool, DataFrame, Index, DataVector, add_names, ColumnIndex, gennames, nrow, ncol, names!, rename!, rename,index
import Base: show, length, isempty


export rep, rep_len,
    table, as_string,
    expand_grid,
    head, tail,
    isempty, isnothing,
    datarange,
    nrow, ncol,
    outer,
    duplicated,
    findinterval,
    matrix,
    List, list, unlist, lapply, as_list,
    seq,
    setequal


include("rep.jl")
include("table.jl")
include("expandgrid.jl")
include("headtail.jl")
include("is.jl")
include("range.jl")
include("dim.jl")
include("outer.jl")
include("duplicated.jl")
include("findinterval.jl")
include("matrix.jl")
include("List.jl")
include("seq.jl")
include("setequal.jl")

end # module
