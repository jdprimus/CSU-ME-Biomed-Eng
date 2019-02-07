%% Problem 2
global sigmay_steel d_steel sigmay_al d_al
d_steel = [406 106 75 43 30 16];
sigmay_steel = [93 129 145 158 189 233];
d_al = [42 16 11 8.5 5 3.1];
sigmay_al = [223 225 225 226 231 238];

% Hall-Petch relation:
% sigmay = sigmao + ky*sqrt(d)
xo = [0, 0];
% steel
fit_params_steel = fminsearch(@ls, xo);
d = (10:5:420);
fit_sigmay = fit_params_steel(1) + fit_params_steel(2)*sqrt(d);
plot(sqrt(d_steel), sigmay_steel)
hold on
plot(sqrt(d), fit_sigmay)
% predict a strength from grain size
plot(sqrt(2), fit_params_steel(1) + fit_params_steel(2)*sqrt(2), 'X')
xlabel('sqrt(d)')
ylabel('Yield Strength')
title('Hall Petch Fit: Steel')
legend('Data','Fit','Prediction')

% aluminum 
fit_params_al = fminsearch(@ls_al, xo);
d = (3:3:42);
fit_sigmay = fit_params_al(1) + fit_params_al(2)*sqrt(d);
figure()
plot(sqrt(d_al), sigmay_al)
hold on
plot(sqrt(d), fit_sigmay)

% predict a strength from grain size
plot(sqrt(2), fit_params_al(1) + fit_params_al(2)*sqrt(2), 'X')
xlabel('sqrt(d)')
ylabel('Yield Strength')
title('Hall Petch Fit: Aluminum')
legend('Data','Fit','Prediction')

% least squares fit steel
function s = ls(so)
global sigmay_steel d_steel
    s = sum((sigmay_steel - (so(1)+so(2)*sqrt(d_steel))).^2);
end

% least squares fit aluminum
function s = ls_al(so)
global sigmay_al d_al
    s = sum((sigmay_al - (so(1)+so(2)*sqrt(d_al))).^2);
end