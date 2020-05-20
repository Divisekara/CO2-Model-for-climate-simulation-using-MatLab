function[particular_rate] = f(particular_year)

years = [1000 1850 1950 1980 2050 2100 2120 2150 2225 2300 2500 5000];
rates = [0.0 0.0 1.0 4.0 8.0 10.0 10.5 10.0 3.5 2.0 0.0 0.0];

x = 1000:1:5000;

%nearest , linear , spline , pchip

y = interp1(years,rates,x,'pchip');

plot(years, rates, 'o', x, y)

particular_rate = y(particular_year-1000)

end
