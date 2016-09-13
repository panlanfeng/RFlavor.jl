"""
    seq(from, to, by, length)
    seq_len(n)
    seq_along(x)

## Description
Implementation for `seq` function in R. `seq` supplies a consistent sequence generating function in julia, so that users don't need to switch between `linspace` and `range` functions when generating sequences.

## Value
The function returns a vector.

## Example
```
seq(0, 1, length = 11)
seq(1, 9, by = 2)
seq(1, 5, by =0.4)
seq(1, -1, length=10)
seq_len(10)
seq_along(rand(10))
```
"""

function seq(from::Real, to::Real, by::Real)
    collect(from:by:to)
end

function seq(from::Real, to::Real; length::Integer=2, by::Real = (to - from)/(length -1))
    collect(from:by:to)
end

function seq_len(n::Integer)
    collect(1:n)
end

function seq_along(x::AbstractVector)
    collect(1:length(x))
end


                                            
