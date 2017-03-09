using Plots
plotlyjs();

include("../julia/intensity_gamma.jl");
include("../julia/utils.jl");

x_true = readcsv("../data/spikes.csv")[:];
rs_true = readcsv("../data/firing_rate_true.csv")[:];

rs_mle = intensity_gamma(x_true);

plot(ts, rs_true, label="True")
plot!(ts, rs_mle, label="Estimated")

xlabel!("Time (s)")
ylabel!("Firing rate (Hz)")
