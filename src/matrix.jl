"""
    matrix(x, nrow, ncol, byrow)

## Descritpion
`matrix` creates a matrix from the given set of values.

## Arguments
* `x`: a real vector
* `nrow`: the desired number of rows
* `ncol`: the desired number of columns
* `byrow`: logical. If `false` (the default) the matrix is filled by
          columns, otherwise the matrix is filled by rows.

## Example
```
matrix(1, 5)
matrix(1.0, 4, 2)
x = rand(10)

matrix(x)
matrix(x, 5)
matrix(x, 5, byrow=true)

matrix(x, ncol = 2)
matrix(x, ncol = 2, byrow = true)

matrix(x, 5, 2, true)
matrix(1:5, 2) # dimension does not match error
matrix(x, 15, 2) # warning: recursively used data

matrix(1, 4)
matrix(1, 4, 2)
matrix(2.0, nrow = 4)
matrix(2.0, nrow = 4, ncol =2)
```
"""

function matrix(x::AbstractVector, nrow::Integer, ncol::Integer, byrow::Bool = false)
    length(x) <= nrow*ncol || throw(DimensionMismatch("Lenth of `x` is greater than `nrow*ncol`."))
    if length(x) == nrow*ncol
        return byrow ? reshape(x, (ncol, nrow))' : reshape(x, (nrow, ncol))
    else
        warn("In matrix(x, $(nrow), $(ncol), $(byrow)): data length [$(length(x))] is not equal to `nrow * ncol` [$(nrow)*$(ncol)], data is recursively used.")
        return byrow ? reshape(rep_len(x, nrow*ncol), (ncol, nrow))' :  reshape(rep_len(x, nrow*ncol), (nrow, ncol))
    end
end

function matrix(x::AbstractVector, nrow::Integer, ncol::Integer; byrow::Bool = false)
    matrix(x, nrow, ncol, byrow)
end

function matrix(x::AbstractVector, nrow::Integer; ncol::Integer = div(length(x), nrow), byrow::Bool = false)
    matrix(x, nrow, ncol, byrow)
end

function matrix(x::AbstractVector; kwargs...)
    kwargs_dict = Dict(kwargs)
    nrow::Integer = get(kwargs_dict, :nrow, -1)
    ncol::Integer = get(kwargs_dict, :ncol, -1)
    byrow::Bool = get(kwargs_dict, :byrow, false)
    if nrow > 0 && ncol > 0
        return matrix(x, nrow, ncol, byrow)
    elseif nrow > 0 && ncol < 0
        return matrix(x, nrow, div(length(x), nrow),byrow)
    elseif nrow < 0 && ncol > 0
        return matrix(x, div(length(x), ncol), ncol, byrow)
    else
        return matrix(x, length(x), 1, byrow)
    end
end

function matrix(x::Real, nrow::Integer, ncol::Integer = 1)
    fill(x, (nrow, ncol))
end

function matrix(x::Real; nrow::Integer = 1, ncol::Integer = 1)
    matrix(x, nrow, ncol)
end
