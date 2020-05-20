%%

% A CO2 model for climate simulation

%%

%variables

%%five principal variables
% p = Partial pressure of carbo dioxide in the atmosphere
% sigma_s = total dissolved carbon concentration in the shallow ocean
% sigma_d = total dissolved carbon concentration in the deep ocean
% alpha_s = alkalinity in the shallow ocean
% alpha_d = alkalinity in the deep ocean

% h_s = hudrogen carbonate in the shallow ocean
% c_s = carbonate in the shallow ocean ocean
% p_s = partial pressure of gaseous carbon dioxide in the shallow ocean

% d = transfer time
% source term f(t)
% u_1 = 
% u_2 = 
% v_s = 
% v_d =
% w = 
% k1 = 
% k2 = 

%%

%The rate of change of the five principal variables

% p_derivative = (p_s - p)/(d) + f(t)/u_1

% sigma_s_derivative = ( (sigma_d - sigma_s)*w - k1 - (p_s - p)/d*u_2)/v_s

% sigma_d_derivative = ( k1 - (sigma_d - sigma_s)*w )/v_d

% alpha_s_derivative = ((alpha_d - alpha_s)*w - k2)/v_s

% alpha_d_derivative = (k2 - (alpha_d - alpha_s)*w)/v_d


%The equlibrium between carbon dioxide and the corbonates 

%%