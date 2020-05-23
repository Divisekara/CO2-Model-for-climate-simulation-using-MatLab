clc,clear
%% A CO2 model for climate simulation
%% variables

% five principal variables

% p = Partial pressure of carbo dioxide in the atmosphere
% sigma_s = total dissolved carbon concentration in the shallow ocean
% sigma_d = total dissolved carbon concentration in the deep ocean
% alpha_s = alkalinity in the shallow ocean
% alpha_d = alkalinity in the deep ocean

% h_s = %hudrogen carbonate in the shallow ocean
% c_s = carbonate in the shallow ocean ocean
% p_s = partial pressure of gaseous carbon dioxide in the shallow ocean

% source term f(t)

%contants
d = 8.64;                %transfer time
u_1 = 4.95*10^2;
u_2 = 4.95*10^(-2);
v_s = 0.12;
v_d = 1.23;
w   = 10^(-3);
k1  = 2.19*10^(-4);
k2  = 6.12*10^(-5);
k3  = 0.997148;
k_4 = 6.79*10^(-2);

%Time interval is thousand years agon and few thousand years ahead
t_interval = 1000:5000;

%Initial Values at t = 1000
p = 1.00;
sigma_s = 2.01;
sigma_d = 2.23;
alpha_s = 2.20;
alpha_d = 2.26;

%%
%The rate of change of the five principal variables
% p_derivative = (p_s - p)/(d) + f(t)/u_1 
% sigma_s_derivative = ( (sigma_d - sigma_s)*w - k1 - (p_s - p)/d*u_2)/v_s
% sigma_d_derivative = ( k1 - (sigma_d - sigma_s)*w )/v_d
% alpha_s_derivative = ((alpha_d - alpha_s)*w - k2)/v_s
% alpha_d_derivative = (k2 - (alpha_d - alpha_s)*w)/v_d

% The equlibrium between carbon dioxide and the corbonates 
% h_s = (sigma_s - sqrt(sigma_s^2 - k3*alpha_s*(s*sigma_s - alpha_s)))/k3 
% c_s = (alpha_s - h_s)/2
% p_s = k4 * h_s^2 /c_s

%% Question number 1 %%%%%%%%%%%%%%%%%%%%
figure(1);
t=2020;
f = sourceFossilFuels1(t);
disp('2020 source term value'),f

%% Question no.2 A %%%%%%%%%%%%%%%%%%%%

figure(2);
subplot(4,1,1);
f(t) = sourceFossilFuels1(t);

domain = [1000 5000];
%Initial Conditions
IC1 = 1.00; % p
IC2 = 2.01; % sigma_s
IC3 = 2.23; % sigma_d
IC4 = 2.20; % alpha_s
IC5 = 2.26; % alpha_d

IC = [IC1, IC2, IC3, IC4,IC5]; %

[IVsol, DVsol] = ode23('DEdef', domain, IC);%

subplot(4,1,2);
plot(IVsol, DVsol(:,1), 'k'),ylabel('Patm CO2') % p
ylim([0,5])

%%% Answer for the 
[val, idx] = max(DVsol(:,1));
maximum_CO2_year = round(IVsol(idx))

subplot(4,1,3);
plot(IVsol, DVsol(:,2), 'b') % sigma_s
hold on
plot(IVsol, DVsol(:,3), 'r'),ylabel('sigma') % sigma_d
ylim([1.8,2.6])
legend('shallow', 'deep')
hold off

subplot(4,1,4);
plot(IVsol, DVsol(:,4), 'g') % alpha_s
hold on
plot(IVsol, DVsol(:,5), 'm'),ylabel('alpha'),xlabel('Date[yr,CE]')% alpha_d
ylim([2,2.4])
legend('shallow', 'deep')
hold off

%% Question 3 A

%For the sawtooth, see the sigma in deep. magnify it, then you can see 
%it clearly.

%sawtooth 1
figure(3);
%Defining the arrays for see a region contains a clear sawtooth
y_array = DVsol(:,2);
y_array = y_array(200:500);
x_array = IVsol(200:500);
plot(x_array, y_array , 'b'),ylabel('sigma_s'),xlabel('Date[yr,CE]') % sigma_s
ylim([2.09,2.19])

%sawtooth 2
figure(4);
%Defining the arrays for see a region contains a clear sawtooth
y_array = DVsol(:,2);
y_array = y_array(400:500);
x_array = IVsol(400:500);
plot(x_array, y_array , 'b'),ylabel('sigma_s'),xlabel('Date[yr,CE]')  % sigma_d
ylim([2.09,2.19])

%%%Oscillation type is 'traingular waves oscillation'

%%
% ode23, ode45, ode23s, ode113, ode23s, ode15s
%{
fprintf('ode23: ')
tic; [IVsol, DVsol] = ode23('DEdef', domain, IC); toc
figure('Name','ode23');
plot(IVsol, DVsol(:,2), 'b'),ylabel('t-years'),xlabel('Date[yr,CE]') 

fprintf('ode15s: ')
tic; [IVsol, DVsol] = ode15s('DEdef', domain, IC); toc 
figure('Name','ode15s');
plot(IVsol, DVsol(:,2), 'b'),ylabel('t-years'),xlabel('Date[yr,CE]')

fprintf('ode23s: ')
tic; [IVsol, DVsol] = ode23s('DEdef', domain, IC); toc
figure('Name','ode23s');
plot(IVsol, DVsol(:,2), 'b'),xlabel('Date[yr,CE]')

fprintf('ode45: ')
tic; [IVsol, DVsol] = ode45('DEdef', domain, IC); toc
figure('Name','ode45');
plot(IVsol, DVsol(:,2), 'b'),xlabel('Date[yr,CE]')

fprintf('ode113: ')
tic; [IVsol, DVsol] = ode113('DEdef', domain, IC); toc
figure('Name','ode113');
plot(IVsol, DVsol(:,2), 'b'),xlabel('Date[yr,CE]')

fprintf('ode23t: ')
tic; [IVsol, DVsol] = ode23t('DEdef', domain, IC); toc
figure('Name','ode23t');
plot(IVsol, DVsol(:,2), 'b'),xlabel('Date[yr,CE]')  % sigma_s

fprintf('ode23tb: ')
tic; [IVsol, DVsol] = ode23tb('DEdef', domain, IC); toc
figure('Name','ode23tb');
plot(IVsol, DVsol(:,2), 'b'),xlabel('Date[yr,CE]')  % sigma_s

%According to the elapsed time we can compare the computational costs.
%These five figures shows us how the ode solvers outputs
%ode15s is the best for this problem considering the computational cost and
%accuracy of the solution(no sawtooth)

%}

%%

options = odeset('RelTol',1e-6,'AbsTol',1e-6,'stats','on')

fprintf('ode23: ')
figure('Name','ode23');
tic; ode23('DEdef', domain, IC, options); toc
disp(" ")

fprintf('ode15s: ')
figure('Name','ode15s');
tic; ode15s('DEdef', domain, IC, options); toc 
disp(" ")

fprintf('ode23s: ')
figure('Name','ode23s');
tic; ode23s('DEdef', domain, IC, options); toc
disp(" ")

fprintf('ode45: ')
figure('Name','ode45');
tic; ode45('DEdef', domain, IC, options); toc
disp(" ")

fprintf('ode113: ')
figure('Name','ode113');
tic; ode113('DEdef', domain, IC, options); toc
disp(" ")

fprintf('ode23t: ')
figure('Name','ode23t');
tic; ode23t('DEdef', domain, IC, options); toc
disp(" ")

fprintf('ode23tb: ')
figure('Name','ode23tb');
tic; ode23tb('DEdef', domain, IC, options); toc
disp(" ")
