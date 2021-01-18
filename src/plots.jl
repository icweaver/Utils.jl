function distplot1D(df, key; quantiles=[0.25, 0.50, 0.75], kwargs...)
    p = @df df stephist(cols(key), fill=true; kwargs...) # Histogram
    qs = @df df quantile(cols(key), quantiles) # Quantiles
    vline!(p, qs)
    return p
end

function distplot2D(df, k1, k2; kwargs...)
    dens = @df df kde((cols(Symbol(k1)), cols(Symbol(k2))))
    plot(dens; fill=true, levels=5, kwargs...)
end

function corner(
        df,
        vars=nothing;
        quantiles=[0.25,0.50,0.75],
        bandwidthx=100,
        bandwidthy=100,
        kwargs...,
    )

    # valid variables
    validvars = propertynames(df)

    # plot all variables by default
    isnothing(vars) && (vars = validvars)
    @assert vars ⊆ validvars "invalid variable name"

    plts = []
    n = length(vars)
    for i in 1:n, j in 1:n
        # Only label axes of first column and last row or plots
        xaxis = i == n
        yaxis = j == 1

        xticks = i == n
        xguide = i == n ? vars[j] : ""
        yticks = i > 1 && j == 1
        yguide = i > 1 && j == 1 ? vars[i] : ""

        # 1D histograms
        if i == j
            #p = plot(xticks=xticks, yticks=yticks)
            p = distplot1D(
                df,
                vars[i];
                quantiles = quantiles,
                xaxis = xaxis,
                yaxis = yaxis,
                xrotation = 45,
                yrotation = 45,
                title = vars[i],
                xticks = xticks,
                yticks = yticks,
                #xguide=xguide,
                #yguide=yguide,
            )
        # 2D histograms
        elseif i > j
            #p = plot(xticks=xticks, yticks=yticks)
            p = distplot2D(
                df,
                vars[j],
                vars[i],
                quantiles = quantiles,
                xaxis = xaxis,
                yaxis = yaxis,
                xrotation = 45,
                yrotation = 45,
                xticks = xticks,
                yticks = yticks,
                #xguide=xguide,
                #yguide=yguide,
            )
        else
            p = plot(framestyle=:none)
        end

        push!(plts, p)
    end

    return plot(plts...; layout=(n, n), leg=:none, colorbar=:none, kwargs...)
end
