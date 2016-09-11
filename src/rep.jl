"""
    rep(x, lengths, times)

Repeat elements of `x` for `lengths` times, and then repeat the whole vector for `times`.

#Arguments
* `lengths`: a vector of the same length as `x`, default to `each .* ones(Int, x)`.
* `each`: an integer, will be suppressed if `lengths` is also given.
* `times` is an integer.

#Example
```
rep(1:4, 1:4, 2)
rep(1:4, 2)
rep(1:4, 2, 3)
rep(1:4, 1:4)
rep(rand(4), lengths=1:4, times=2)
rep(rand(4), each=3, times=2)
```
"""
function rep{T <: Integer}(x::AbstractVector, lengths::AbstractVector{T}, times::Integer=1)
    if length(x) != length(lengths)
        throw(DimensionMismatch("vector lengths must match"))
    end
    res = similar(x, sum(lengths))
    i = 1
    for idx in 1:length(x)
        tmp = x[idx]
        for kdx in 1:lengths[idx]
            res[i] = tmp
            i += 1
        end
    end
    return Compat.repeat(res, outer=times)
end

rep(x::AbstractVector, each::Integer, times::Integer)=Compat.repeat(x, inner=each, outer=times)

rep(x::AbstractVector, times::Integer)=Compat.repeat(x, outer=times)

#There seems no way to allow lengths to be union of vector and integer
rep{T<:Integer}(x::AbstractVector; each::Integer=1, lengths::AbstractVector{T} = fill(each, length(x)), times::Integer = 1) = rep(x, lengths, times)
