# The filter version below would be great if the dict keys were already keys,
# but they're not cause python =\
function sub_dict(dict, keys)
    Dict(
        Symbol(index)=>value for (index, value) in pairs(dict) if index ∈ keys
    )
end

# d_gpts = filter(
# 	p -> p.first ∈ ["p", "t0", "P", "rho", "inc", "b", "aRs", "q1"],
# 	d_pkl_gpts
# )
