using Plots
plotlyjs()

include("../julia/QQplot.jl");
include("../julia/utils.jl");

x_true = readcsv("../data/spikes.csv")[:];
rs_estimated = readcsv("../data/firing_rate_estimated.csv")[:];

QQplot(rs_estimated, x_true)
title!("Renewal Gamma")
xlabel!("data")
ylabel!("Maximum likelihood")
