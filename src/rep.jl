"""
    rep(x, each, times)

Repeat each elements of `x` for `each` times, and then repeat the whole vector for `times`.

#Arguments
* `each` can be an integer or a vector of the same length as `x`.
* `times` is an integer.

#Note
`rep(1:4, each=2)` does not work! Use `rep(1:4, 1:4)` instead.
#Example
```
rep(1:4, 1:4, 2)
rep(1:4, 2, 2)
rep(rand(4), each=2, times=2)
```
"""
function rep{T <: Integer}(x::AbstractVector, each::AbstractVector{T}, times::Integer=1)
    if length(x) != length(each)
        throw(DimensionMismatch("vector lengths must match"))
    end
    res = similar(x, sum(each))
    i = 1
    for idx in 1:length(x)
        tmp = x[idx]
        for kdx in 1:each[idx]
            res[i] = tmp
            i += 1
        end
    end
    return Compat.repeat(res, outer=times)
end

rep(x::AbstractVector, each::Integer, times::Integer=1) = Compat.repeat(x; inner=each, outer=times)
#There seems no way to allow each to be union of vector and integer
rep{T<:Integer}(x::AbstractVector; each::AbstractVector{T} = ones(Int, length(x)), times::Integer = 1) = rep(x, each, times)
