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

"""
    table(x...)

Show the counts of `x`.
"""
table=freqtable
