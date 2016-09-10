"""
# Description
Given a vector of non-decreasing breakpoints in `vec`, find the
interval containing each element of `x`. Default is left most interval closed.
# Example
```
findinterval(0:5, 1:4)
findinterval(1, 1:2)
findinterval(1, [0.5, 1, 2])
```
"""

function findinterval{T<:Number}(x::AbstractVector{T}, vec::AbstractVector{T})
    if !issorted(vec)
        error("Error in findInterval:
          'vec' must be sorted non-decreasingly.")
    else
        out = similar(x, Int64)
        for i in 1:length(x)
            out[i] = searchsortedlast(vec, x[i])
        end
        return out
    end
end

function findinterval(x::Number, vec::AbstractVector)
    if !issorted(vec)
        error("Error in findInterval:
          'vec' must be sorted non-decreasingly.")
    else
        return searchsortedlast(vec, x)
    end
end

