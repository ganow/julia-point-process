using Plots
plotlyjs();

include("../julia/intensity_inhomopoisson.jl");
include("../julia/utils.jl");

x_true = readcsv("../data/spikes.csv")[:];
rs_true = readcsv("../data/firing_rate_true.csv")[:];

rs_kernel = intensity_inhomopoisson(x_true, w=0.01);

plot(ts, rs_true, label="True")
plot!(ts, rs_kernel, label="Estimated")

xlabel!("Time (s)")
ylabel!("Firing rate (Hz)")
