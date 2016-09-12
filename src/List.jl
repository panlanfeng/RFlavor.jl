abstract AbstractList

columns(d::AbstractList)=d.columns
index(d::AbstractList)=d.colindex
Base.names(df::AbstractList) = names(index(df))
_names(x::Index) = x.names
_names(df::AbstractList) = _names(index(df))
Base.length(df::AbstractList) = length(_names(df))
Base.endof(df::AbstractList) = length(_names(df))

Base.haskey(df::AbstractList, key::Any) = haskey(index(df), key)
Base.get(df::AbstractList, key::Any, default::Any) = haskey(df, key) ? df[key] : default
Base.isempty(df::AbstractList) = length(df) == 0


Base.start(itr::AbstractList) = 1
#Base.length(itr::AbstractList) = length(itr)
Base.done(itr::AbstractList, j::Int) = j > length(itr)
Base.next(itr::AbstractList, j::Int) = ((_names(itr)[j], itr[j]), j + 1)
Base.getindex(itr::AbstractList, j::Any) = itr[j]

function Base.map(f::Function, d::AbstractList)
    res = List()
    for (n, v) in d
        res[n] = f(v)
    end
    res
end

function lapply(d::AbstractList, f::Function, args...; kwargs...)
    map(x->f(x, args...; kwargs...), d)
end

function unlist(d::AbstractList, recursive::Bool=false)
    res = Any[]
    for (k, v) in d
        if isa(v, AbstractList) && recursive
            append!(res, unlist(v, recursive))
        else
            push!(res, v)
        end
    end
    res
end

function names!(df::AbstractList, vals; allow_duplicates=false)
    names!(index(df), vals; allow_duplicates=allow_duplicates)
    return df
end
function rename!(df::AbstractList, args...)
    rename!(index(df), args...)
    return df
end
rename!(f::Function, df::AbstractList) = rename!(df, f)
rename(df::AbstractList, args...) = rename!(copy(df), args...)
rename(f::Function, df::AbstractList) = rename(df, f)



type List <: AbstractList
    columns::Vector{Any}
    colindex::Index

    function List(columns::Vector{Any}, colindex::Index)
        ncols = length(columns)
        if length(colindex) != ncols
            msg = "Columns and column index must be the same length"
            throw(ArgumentError(msg))
        end
        new(columns, colindex)
    end
end

typealias list List

function Base.convert(::Type{List}, df::DataFrames.AbstractDataFrame)
    List(df.columns, df.colindex)
end

function show(io::IO, d::List)
    print(io, showindent(d))
end
function showindent(d::List, indent::String="")
    k = _names(d.colindex)
    res=sprint(println, indent, "$(length(d)) elements List:")
    for i in 1:length(d.columns)
        res*=sprint(println, indent, "[$i] ", k[i], ": ")
        if isa(d.columns[i], List)
            indent2 = indent*"    "
            res*=sprint(println, indent, showindent(d.columns[i], indent2))
        else
            res*=sprint(println, indent, "    ", d.columns[i])
        end
    end
    res
end

function List(; kwargs...)
    result = List(Any[], Index())
    for (k, v) in kwargs
        result[k] = v
    end
    return result
end
function List(columns::Vector{Any},
                   cnames::Vector{Symbol} = gennames(length(columns)))
    return List(columns, Index(cnames))
end

index(df::List) = df.colindex
columns(df::List) = df.columns


function Base.getindex(df::List, col_ind::ColumnIndex)
    selected_column = index(df)[col_ind]
    return df.columns[selected_column]
end

function Base.getindex{T <: ColumnIndex}(df::List, col_inds::AbstractVector{T})
    selected_columns = index(df)[col_inds]
    new_columns = df.columns[selected_columns]
    return List(new_columns, Index(_names(df)[selected_columns]))
end

# df[:] => (Sub)?List
Base.getindex(df::List, col_inds::Colon) = copy(df)



###

isnextcol(df::List, col_ind::Symbol) = true
function isnextcol(df::List, col_ind::Real)
    return length(df) + 1 == @compat Int(col_ind)
end

function nextcolname(df::List)
    return @compat(Symbol(string("x", length(df) + 1)))
end

# Will automatically add a new column if needed
function insert_single_column!(df::List,
                               dv::Any,
                               col_ind::ColumnIndex)

    if haskey(index(df), col_ind)
        j = index(df)[col_ind]
        df.columns[j] = dv
    else
        if typeof(col_ind) <: Symbol
            push!(index(df), col_ind)
            push!(df.columns, dv)
        else
            if isnextcol(df, col_ind)
                push!(index(df), nextcolname(df))
                push!(df.columns, dv)
            else
                error("Cannot assign to non-existent column: $col_ind")
            end
        end
    end
    return dv
end


# df[SingleColumnIndex] = Single Item (EXPANDS TO NROW(DF) if length(DF) > 0)
function Base.setindex!(df::List,
                v::Any,
                col_ind::ColumnIndex)
    insert_single_column!(df, v, col_ind)
end

# df[MultiColumnIndex] = List
function Base.setindex!(df::List,
                new_df::List,
                col_inds::AbstractVector{Bool})
    setindex!(df, new_df, find(col_inds))
end
function Base.setindex!{T <: ColumnIndex}(df::List,
                                  new_df::List,
                                  col_inds::AbstractVector{T})
    for j in 1:length(col_inds)
        insert_single_column!(df, new_df[j], col_inds[j])
    end
    return df
end

# df[MultiColumnIndex] = Single Item (REPEATED FOR EACH COLUMN; EXPANDS TO NROW(DF) if length(DF) > 0)
function Base.setindex!(df::List,
                val::Any,
                col_inds::AbstractVector{Bool})
    setindex!(df, val, find(col_inds))
end
function Base.setindex!{T <: ColumnIndex}(df::List,
                                  val::Any,
                                  col_inds::AbstractVector{T})

    for col_ind in col_inds
        insert_single_column!(df, val, col_ind)
    end
    return df
end

# df[:] = AbstractVector or Single Item
Base.setindex!(df::List, v, ::Colon) = (df[1:length(df)] = v; df)


# Special deletion assignment
#Base.setindex!(df::List, x::Void, col_ind::Int) = delete!(df, col_ind)

##############################################################################
##
## Mutating Associative methods
##
##############################################################################

Base.empty!(df::List) = (empty!(df.columns); empty!(index(df)); df)

function Base.insert!(df::List, col_ind::Int, item::AbstractVector, name::Symbol)
    0 < col_ind <= length(df) + 1 || throw(BoundsError())

    insert!(index(df), col_ind, name)
    insert!(df.columns, col_ind, item)
    df
end
Base.insert!(df::List, col_ind::Int, item, name::Symbol) =
    insert!(df, col_ind, item, name)

function Base.merge!(df::List, others::AbstractList...)
    for other in others
        for n in _names(other)
            df[n] = other[n]
        end
    end
    return df
end
Base.merge(df::List, others::AbstractList...) = merge!(List(), df, others...)
##############################################################################
##
## Copying
##
##############################################################################

# A copy of a List points to the original column vectors but
#   gets its own Index.
Base.copy(df::List) = List(copy(columns(df)), copy(index(df)))

# Deepcopy is recursive -- if a column is a vector of Lists, each of
#   those Lists is deepcopied.
function Base.deepcopy(df::List)
    List(deepcopy(columns(df)), deepcopy(index(df)))
end

##############################################################################
##
## Deletion / Subsetting
##
##############################################################################

# delete!() deletes columns; deleterows!() deletes rows
# delete!(df, 1)
# delete!(df, :Old)
function Base.delete!(df::List, inds::Vector{Int})
    for ind in sort(inds, rev = true)
        if 1 <= ind <= length(df)
            splice!(df.columns, ind)
            delete!(index(df), ind)
        else
            throw(ArgumentError("Can't delete a non-existent List column"))
        end
    end
    return df
end
Base.delete!(df::List, c::Int) = delete!(df, [c])
Base.delete!(df::List, c::Any) = delete!(df, index(df)[c])


##############################################################################
##
## Hcat specialization
##
##############################################################################

# hcat! for 2 arguments
function hcat!(df1::List, df2::AbstractList)
    u = add_names(index(df1), index(df2))
    for i in 1:length(u)
        df1[u[i]] = df2[i]
    end

    return df1
end
hcat!{T}(df::List, x::DataVector{T}) = hcat!(df, List(Any[x]))
hcat!{T}(df::List, x::Vector{T}) = hcat!(df, List(Any[DataArray(x)]))
hcat!{T}(df::List, x::T) = hcat!(df, List(Any[DataArray([x])]))

# hcat! for 1-n arguments
hcat!(df::List) = df
hcat!(a::List, b, c...) = hcat!(hcat!(a, b), c...)

# hcat
Base.hcat(df::List, x) = hcat!(copy(df), x)


##############################################################################
##
## Pooling
##
##############################################################################


function Base.append!(df1::List, df2::AbstractList)
   _names(df1) == _names(df2) || error("Column names do not match")
   eltypes(df1) == eltypes(df2) || error("Column eltypes do not match")
   ncols = length(df1)
   # TODO: This needs to be a sort of transaction to be 100% safe
   for j in 1:ncols
       append!(df1[j], df2[j])
   end
   return df1
end

function Base.convert(::Type{List}, A::Matrix)
    n = size(A, 2)
    cols = Array(Any, n)
    for i in 1:n
        cols[i] = A[:, i]
    end
    return List(cols, Index(gennames(n)))
end

function _List_from_associative(dnames, d::Associative)
    p = length(dnames)
    p == 0 && return List()
    columns  = Array(Any, p)
    colnames = Array(Symbol, p)
    n = length(d[dnames[1]])
    for j in 1:p
        name = dnames[j]
        col = d[name]
        columns[j] = DataArray(col)
        colnames[j] = Symbol(name)
    end
    return List(columns, Index(colnames))
end

function Base.convert(::Type{List}, d::Associative)
    dnames = collect(keys(d))
    return _List_from_associative(dnames, d)
end

# A Dict is not sorted or otherwise ordered, and it's nicer to return a
# List which is ordered in some way
function Base.convert(::Type{List}, d::Dict)
    dnames = collect(keys(d))
    sort!(dnames)
    return _List_from_associative(dnames, d)
end


##############################################################################
##
## push! a row onto a List
##
##############################################################################

function Base.push!(df::List, associative::Associative{Symbol,Any})
    i = 1
    for nm in _names(df)
        try
            push!(df[nm], associative[nm])
        catch
            #clean up partial row
            for j in 1:(i - 1)
                pop!(df[_names(df)[j]])
            end
            msg = "Error adding value to column :$nm."
            throw(ArgumentError(msg))
        end
        i += 1
    end
end

function Base.push!(df::List, associative::Associative)
    i = 1
    for nm in _names(df)
        try
            val = get(() -> associative[string(nm)], associative, nm)
            push!(df[nm], val)
        catch
            #clean up partial row
            for j in 1:(i - 1)
                pop!(df[_names(df)[j]])
            end
            msg = "Error adding value to column :$nm."
            throw(ArgumentError(msg))
        end
        i += 1
    end
end

# array and tuple like collections
function Base.push!(df::List, iterable::Any)
    if length(iterable) != length(df.columns)
        msg = "Length of iterable does not match List column count."
        throw(ArgumentError(msg))
    end
    i = 1
    for t in iterable
        try
            push!(df.columns[i], t)
        catch
            #clean up partial row
            for j in 1:(i - 1)
                pop!(df.columns[j])
            end
            msg = "Error adding $t to column :$(_names(df)[i]). Possible type mis-match."
            throw(ArgumentError(msg))
        end
        i += 1
    end
end
