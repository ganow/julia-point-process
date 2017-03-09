using Plots
plotlyjs()

include("../julia/pprocess_gamma.jl");

x_gamma, rs_gamma = pprocess_gamma(20.0, 0.8);

plot(ts, rs_gamma)
scatter!(x_gamma, zeros(length(x_gamma)))
xlabel!("Time (s)")
ylabel!("Firing rate (Hz)")

