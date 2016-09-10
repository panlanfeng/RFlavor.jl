head(dv::AbstractVector)=dv[1:min(6, end)]
tail(dv::AbstractVector)=dv[max(end-6, 1):end]

head(dv::AbstractMatrix)=dv[1:min(6, end),:]
tail(dv::AbstractMatrix)=dv[max(end-6, 1):end,:]
