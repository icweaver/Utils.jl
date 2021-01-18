module Utils

using PyCall, DataFrames, KernelDensity, Statistics, StatsPlots, PlotlyBase

export corner, load_pickle, sub_dict

include("load.jl")
include("plots.jl")

function __init__()
    py"""
    import numpy as np
    import pickle

    def load_pickle(fpath):
        with open(fpath, "rb") as f:
            data = pickle.load(f)
        return data
    """
end
load_pickle = py"load_pickle"

end # module
