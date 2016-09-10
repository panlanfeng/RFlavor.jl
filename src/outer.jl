
"""
# Arguments
* `x`, `y`: First and second arguments for function `FUN`. Typically a vector.
* `FUN`: a function to use on the outer products
* `args...`: optional *keywords* arguments passed to `FUN`
        
Example:
outer(1:4, 1:4)
outer(1:4, 1:4, +)
outer(1:4, 1:4, (x, y) -> x^2 + y^2)

function tmp(x, y; z=1.0)
    x^2 + y^2 + z
end
outer(1:4, 1:4, FUN=tmp, z=2.0)
"""

function outer(x::AbstractVector, y::AbstractVector, FUN::Function = *, args...)
    [FUN(i, j; args...) for i in x, j in y]
end

function outer(x::AbstractVector, y::AbstractVector; FUN::Function = *, args...)
    outer(x, y, FUN, args...)
end


