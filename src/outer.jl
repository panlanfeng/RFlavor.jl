
"""
The outer product of two arrays, returning a matrix `A` with dimension `hcat(size(x), size(y))`.

# Arguments
* `x`, `y`: First and second arguments for function `FUN`. Typically a vector.
* `FUN`: a function to use on the outer products
* `args`: optional arguments to `FUN`
* `kwargs...`: optional keywords arguments passed to `FUN`

Example:
```
outer(1:4, 1:4)
outer(1:4, 1:4, +)
outer(1:4, 1:4, (x, y) -> x^2 + y^2)

function tmp(x, y; z=1.0)
    x^2 + y^2 + z
end
outer(1:4, 1:4, tmp, z=2.0)
function tmp2(x, y, z=1.0)
    x^2 + y^2 + z
end
outer(1:4, 1:4, tmp2, 2.0)
```
"""
function outer(x::AbstractArray, y::AbstractArray, FUN::Function, args...; kwargs...)
    [FUN(i, j, args...; kwargs...) for i in x, j in y]
end
outer(x::AbstractArray, y::AbstractArray, args...; FUN::Function=*, kwargs...) = outer(x, y, FUN, args...; kwargs...)
