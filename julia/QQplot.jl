include("./params.jl")

function QQplot(rs, data)
    # Example usage:
    # x = 0.5-0.5*log(rand(1,1e3));
    # w = 0.001;
    # rs = sskernel(x, w);
    # QQplot(rs, x)
    #
    # Input argument
    # rs: Estimated intensity function
    # data: Spike time

    R=cumsum(rs*dt);

    x_step = data/dt;
    x_round = Int.(ceil(transpose(x_step))+1);

    R_x = R[x_round][:];
    tau = diff(R_x);

    u_hat = 1-exp(-tau);
    u_hat_sorted = sort(u_hat);

    n = length(u_hat);
    u = ([1:n]-0.5)/n;

    cz =linspace(0,1,100);
    confb95 = 1.96*sqrt(cz.*(1-cz)/n);
    confb99 = 2.575*sqrt(cz.*(1-cz)/n);
    p_x = [0,1]; p_y = [0,1];
    plot(p_x, p_y, color="black", linewidth=2.0, linestyle=:dash, label="")
    plot!(cz, cz-confb95, color="black", linewidth=2.0, linestyle=:solid, label="")
    plot!(cz, cz+confb95, color="black", linewidth=2.0, linestyle=:solid, label="")

    plot!(u, u_hat_sorted, linewidth=0, marker="", label="")
end
