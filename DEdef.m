function [derivatives] = DEdef(t, D)
    %Independent variable = t
    
    %% Constants used for ode system
    d = 8.64;                %transfer time
    u_1 = 4.95*10^2;
    u_2 = 4.95*10^(-2);
    v_s = 0.12;
    v_d = 1.23;
    w   = 10^(-3);
    k1  = 2.19*10^(-4);
    k2  = 6.12*10^(-5);
    k3  = 0.997148;
    k4 = 6.79*10^(-2);
    f = sourceFossilFuels2(t);
    
    %%dependant variables
    p = D(1);
    sigma_s = D(2);
    sigma_d = D(3);
    alpha_s = D(4);
    alpha_d = D(5);
    
    %% Threee equilibrium equations
    h_s = (sigma_s - sqrt(sigma_s^2 - k3*alpha_s*(2*sigma_s - alpha_s)))/k3;
    c_s = (alpha_s - h_s)/2;
    p_s = k4 * h_s^2 /c_s;
    
    %% Ode equations
    derivatives=[   (p_s - p)/(d) + f/u_1 ;
                    ((sigma_d - sigma_s)*w - k1 - (p_s - p)/d*u_2)/v_s;
                    (k1-(sigma_d - sigma_s)*w)/v_d;
                    ((alpha_d - alpha_s)*w - k2)/v_s;
                    (k2 - (alpha_d - alpha_s)*w)/v_d];
                
end
