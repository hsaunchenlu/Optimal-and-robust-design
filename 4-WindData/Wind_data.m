
close all
clc
clear

%% Read Data
% read data from txt file
wind_speed = textread('windspeed.txt');
wind_direction = textread('winddirection.txt');

%% Data Filter
% filter wind speed data to meet the requirement of probability plotting

% Changing the negtive wind speed data to 1e-1 because that is unreasonable 
for i = 1:4046
    if wind_speed(i) < 0
        wind_speed(i) = 1e-1;
    end
end

% Changing angle 0 degree to 360 degree to meet the requirement of Weibull
% probability plotting.
for i = 1:4046
    if wind_direction(i) == 0
        wind_direction(i) = 360;
    end
end

%%  Probability Plot
% wind speed probability plot
WSPPNOR = figure;
probplot('normal',wind_speed);

WSPPEXP = figure;
probplot('exponential',wind_speed);

WSPPWBL = figure;
probplot('wbl',wind_speed);
 

% wind direction probability plot
WDPPNOR = figure;
 probplot('normal',wind_direction);
 
WDPPEXP = figure;
 probplot('exponential',wind_direction);
 
WDPPWBL = figure;
 probplot('wbl',wind_direction);
 
 %% Maximum Likelihood Estimates
% wind speed maximum likelihood estimates
WSmle_normal = mle(wind_speed,'distribution','normal')

WSmle_exponential = mle(wind_speed,'distribution','exponential')

WSmle_weibull = mle(wind_speed,'distribution','weibull')

% wind direction maximum likelihood estimates
WDmle_normal = mle(wind_direction,'distribution','normal')

WDmle_exponential = mle(wind_direction,'distribution','exponential')

WDmle_weibull = mle(wind_direction,'distribution','weibull')

%% To view the whole direction data by histogram
figure;
histogram(wind_direction,30);

%% Modify the wind direction data
% shift 180 degree 
for i = 1:4046
    if wind_direction(i) < 180
        wind_direction(i) = wind_direction(i) + 180;
    elseif wind_direction(i) > 180
        wind_direction(i) = wind_direction(i) - 180;
    end
end
% output the new result of new data
figure;
histogram(wind_direction,30);

WDPPNOR = figure;
 probplot('normal',wind_direction);
 
WDPPEXP = figure;
 probplot('exponential',wind_direction);
 
WDPPWBL = figure;
 probplot('wbl',wind_direction);

WDmle_normal_new = mle(wind_direction,'distribution','normal')

WDmle_exponential_new = mle(wind_direction,'distribution','exponential')

WDmle_weibull_new = mle(wind_direction,'distribution','weibull')

