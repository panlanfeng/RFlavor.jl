"""
    rep(x, lengths, times)

Repeat elements of `x` for `lengths` times, and then repeat the whole vector for `times`.

# Arguments
* `lengths`: a vector of the same length as `x`, default to `each .* ones(Int, x)`.
* `each`: an integer, will be suppressed if `lengths` is also given.
* `times` is an integer.

# Example
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

function rep(x::AbstractVector; kwargs...)
    kw_dict = Dict(kwargs)
    times = get(kw_dict, :times, 1)
    each_has = haskey(kw_dict, :each)
    lengths_has = haskey(kw_dict, :lengths)
    each_has && lengths_has && warn("Keywords `each` and `lengths` are both specified. `each` is suppressed.")
    if lengths_has
        lengths = get(kw_dict, :lengths, ones(Int, length(x)))
        return rep(x, lengths, times)
    else
        each = get(kw_dict, :each, 1)
        return rep(x, each, times)
    end
end

function rep_len(x::AbstractVector, length_out::Integer)
    nx = length(x)
    if nx > length_out
        error("length_out must be longer than x")
    end
    d = cld(length_out, nx)
    rep(x, 1, d)[1:length_out]
end
