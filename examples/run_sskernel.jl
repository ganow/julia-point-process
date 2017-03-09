using Plots
plotlyjs();

include("../julia/sskernel.jl");
include("../julia/utils.jl");

x_true = readcsv("../data/spikes.csv")[:];
rs_true = readcsv("../data/firing_rate_true.csv")[:];

ws = linspace(0.01,2.5,100);
rs_kernel = sskernel(x_true, ws=ws);

plot(ts, rs_true, label="True")
plot!(ts, rs_kernel, label="Estimated")

xlabel!("Time (s)")
ylabel!("Firing rate (Hz)")

# C = get_costfunc(x_inhomogeneous)

# plot(ws, C.(ws));
# xlabel!("w");
# ylabel!("C(w)");
