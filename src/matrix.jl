"""
# Descritpion
`matrix` creates a matrix from the given set of values.


# Arguments
* `x`: a real vector
* `nrow`: the desired number of rows
* `ncol`: the desired number of columns
* `byrow`: logical. If `false` (the default) the matrix is filled by
          columns, otherwise the matrix is filled by rows.

# Example
```
matrix(1, 5)
matrix(1.0, 4, 2)
matrix(rand(10), 5)
matrix(1:10, 5)
matrix(1:10, ncol = 2)
matrix(1:10, 5, byrow = true)
matrix(1:5,2) # error
matrix(1:5, ncol=2) # error
```
"""

function matrix(x::AbstractVector, nrow::Integer, ncol::Integer, byrow::Bool = false)
    length(x) % nrow == 0 && length(x) == nrow*ncol || throw(DimensionMismatch("Lenth of `x` is not a multiple of `nrow` and `ncol`."))
    if byrow
        return reshape(x, (Int(ncol), Int(nrow)))'
    else
        return reshape(x, (Int(nrow), Int(ncol)))
    end
end

function matrix(x::AbstractVector, nrow::Integer; byrow::Bool = false)
    length(x) % nrow == 0 || throw(DimensionMismatch("Lenth of `x` is not a multiple of `nrow`."))
    matrix(x, nrow, Int(length(x)/nrow), byrow)
end

function matrix(x::AbstractVector; ncol::Integer = 1, byrow::Bool = false)
    length(x) % ncol == 0 || throw(DimensionMismatch("Lenth of `x` is not a multiple of `ncol`."))
    matrix(x, Int(length(x)/ncol), ncol, byrow)
end

function matrix(x::Real, nrow::Integer, ncol::Integer = 1)
    fill(float(x), (nrow, ncol))
end

function matrix(x::Real; nrow::Integer = 1, ncol::Integer = 1)
    matrix(x, nrow, ncol)
end
