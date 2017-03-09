using Plots
plotlyjs()

include("../julia/pprocess_inhomopoisson.jl");

f = 0.5;
lambda = 20*(1+sin(2.0 * pi * f * ts));
x_inhomopoisson, rs_inhomopoisson = pprocess_inhomopoisson(lambda);

plot(ts, rs_inhomopoisson)
scatter!(x_inhomopoisson, zeros(length(x_inhomopoisson)))
xlabel!("Time (s)")
ylabel!("Firing rate (Hz)")
