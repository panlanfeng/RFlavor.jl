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
# matrix(1:10, nrow = 5) # Error
matrix(1:10, ncol = 2)
# matrix(1:10, nrow = 5, ncol = 2) # Error
matrix(1:10, 5, byrow = false)
matrix(1:5,2)
```
"""

function matrix{T <: Real, S <:Real}(x::AbstractVector, nrow::T, ncol::S, byrow::Bool = true)
    length(x) % nrow == 0 && length(x) == nrow*ncol || throw(DimensionMismatch("Lenth of `x` is not a multiple of `nrow` and `ncol`."))
    if byrow
        return reshape(float(x), (Int(nrow), Int(ncol)))
    else
        return reshape(float(x), (Int(nrow), Int(ncol)))'
    end
end

# function matrix{T <: Real, S <:Real}(x::AbstractVector; nrow::T = 1,
#                                      ncol::S = 1, byrow::Bool = true)
#     matrix(x, nrow, ncol, byrow)
# end

function matrix{T <: Real}(x::AbstractVector, nrow::T; byrow::Bool = true)
    matrix(x, nrow, length(x)/nrow, byrow)
end

# function matrix{T <: Real}(x::AbstractVector; nrow::T = 1, byrow::Bool = true)
#     matrix(x, nrow, length(x)/nrow, byrow)
# end

function matrix{S <: Real}(x::AbstractVector; ncol::S = 1, byrow::Bool = true)
    matrix(x, length(x)/ncol, ncol, byrow)
end

function matrix{T <: Real, S <: Real}(x::Real, nrow::T = 1, ncol::S = 1)
    fill(float(x), (Int(nrow), Int(ncol)))
end

function matrix{T <: Real, S <: Real}(x::Real; nrow::T = 1, ncol::S = 1)
    matrix(x, Int(nrow), Int(ncol))
end    
