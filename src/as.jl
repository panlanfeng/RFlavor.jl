"""
    as_string(x)

Convert any array `x` into a `String` Matrix.
"""
function as_string(x)
    sprint(showcompact, x)
end
function as_string(x::AbstractArray)
    #broadcast(as_string, x)
    [sprint(showcompact, ix) for ix in x]
end

function as_numeric(x::String)
    res=parse(x)
    if !isa(res, Number)
        error("$(x) cannot be parse as a number")
    end
    res
end
as_numeric(x::AbstractArray{String})=[as_numeric(ix) for ix in x]
