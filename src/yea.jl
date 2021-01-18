### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ b46a1e96-d4e9-47a0-818b-d69146434db3
using Revise; using Utils

# ╔═╡ a367e7ea-59ae-11eb-3ae8-7935e1bab240
using PlutoUI, DataFramesMeta, Glob, AstroImages, HDF5, Dates, Printf, StatsPlots, CSV, CCDReduction, FITSIO, DataFrames, RecursiveArrayTools, BenchmarkTools, Statistics, PaddedViews, PlotlyBase, KernelDensity, PyCall

# ╔═╡ 78636301-9ad5-4562-8526-fb92a5e88c84
TableOfContents()

# ╔═╡ 3fc21e1c-355f-40a6-a846-2acea97bdd94
md"""### $(@bind run_GPTS_WLC_corner CheckBox()) GPTS WLC Corner Plot

Visualize GPT data stored in
"""

# ╔═╡ bac5f350-ce60-4d18-bdbd-41f51dea7837
if run_GPTS_WLC_corner
	# Load
	gpts_pkl_to_dict = load_pickle(
		"Projects/HATP23b/data_detrending/out_c/HATP23b/hp23b_170609_custom/white-light/BMA_posteriors.pkl"
	)
	println(keys(gpts_pkl_to_dict))
	const gpts_params = ["p", "t0", "P", "rho", "inc", "b", "aRs", "q1"]
	gpts_params_dict = sub_dict(gpts_pkl_to_dict, gpts_params)
	
	df_gpts = DataFrame(gpts_params_dict)
	
	let
		corner(df_gpts, Symbol.(gpts_params), size=(15_000, 30_000))
		png("/home/mango/Desktop/test")
	end
end

# ╔═╡ 2cab7acb-65e8-477b-88ab-16ed23c14c4e
md"""
## Plot configs
"""

# ╔═╡ b16c144e-064f-49a7-9812-52cd695e7b4b
theme(:dark); plotly()

# ╔═╡ 16df4db5-a788-4b5c-85d5-23937a1a890a
const pal = palette(["#f5d300", "#d55e00", "#08f7fe", "#0173b2", "#029e73"])

# ╔═╡ d2951668-8a8f-4cae-a011-4390708933ac
default(
	titlefont = "Lato",
	guidefont = "Lato",
	markerstrokewidth = 0,
	palette=pal,
)

# ╔═╡ 7cb0686e-00db-4016-8c55-a69a4c260ebe
md"""
## Packages
"""

# ╔═╡ Cell order:
# ╟─78636301-9ad5-4562-8526-fb92a5e88c84
# ╟─3fc21e1c-355f-40a6-a846-2acea97bdd94
# ╠═bac5f350-ce60-4d18-bdbd-41f51dea7837
# ╟─2cab7acb-65e8-477b-88ab-16ed23c14c4e
# ╠═b16c144e-064f-49a7-9812-52cd695e7b4b
# ╠═d2951668-8a8f-4cae-a011-4390708933ac
# ╠═16df4db5-a788-4b5c-85d5-23937a1a890a
# ╟─7cb0686e-00db-4016-8c55-a69a4c260ebe
# ╠═b46a1e96-d4e9-47a0-818b-d69146434db3
# ╠═a367e7ea-59ae-11eb-3ae8-7935e1bab240
