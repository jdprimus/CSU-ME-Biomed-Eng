%% MECH532 HW4_5
% Jeremy Primus
% October 4, 2018

%% Problem 5
% If the data is consistent with work-hardening theory, it should follow the Taylor
% relation for strength vs dislocation density.
% Taylor relation:
% tau = tau_o + alpha*G*b*rho^(1/2);
% We can lump together the constants and plot rho against the log of shear stress.  
% The resulting line should have a slope of one half if consistent with work hardening theory.

global tau rho

tau = [195 205 250 310 345 365].*10^6;              % flow strength
epsilon = [0.058 0.166 0.232 0.463 0.928 1.39];     % deformation strain

% we can obtain rho, the dislocation density from the given relation.
rho = (2.1e14)*(1-0.99*exp(-1.45*epsilon)).^2

so = [1e6,1];
fit_params = fminsearch(@lsfit, so);

loglog(rho, tau)
grid on 
hold on
rho_x = logspace(12.2, 14.2);
taufit = fit_params(1) + (fit_params(2))*((rho_x).^0.5);
loglog(rho_x, taufit)
xlabel('Dislocation Density')
ylabel('Resolved Shear Stress')

figure()
plot(log10(rho_x), log10(taufit))

slope = log10(tau(end) - tau(1))/log10(rho(end)-rho(1)) % calculate overall slope
fitslope = log10(taufit(end)-taufit(1))/(log10(rho_x(end)-rho_x(1)))
% least squares fit     
function s = lsfit(so)
global tau rho
    s = sum((((tau)) - (so(1) + so(2)*sqrt(rho))).^2);
end

