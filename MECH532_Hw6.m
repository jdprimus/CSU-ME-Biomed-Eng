%% MECH532 Homework #6
% Jeremy Primus
% October 19, 2018

%% Problem 1
% intialization
stress = [10:10:100];
global strain_rate_1700k
strain_rate_1700k =  [2e-8 4e-8 6e-8 8e-8 2.3e-7 5e-7 9.9e-7 1.8e-6 3.1e-6 4.9e-6];
strain_rate_1810k = [7e-8 1.4e-7 2.1e-7 2.8e-7 8e-7 1.8e-6 3.5e-6 6.3e-6 1.1e-5 1.7e-5];
strain_rate_1940k = [4.2e-7 8.4e-7 1.3e-6 1.7e-6 4.8e-6 1.1e-5 2.1e-5 3.8e-5 6.5e-5 1e-4];
strain_rate = [strain_rate_1700k; strain_rate_1810k; strain_rate_1940k];

% a) plot creep rate vs. stress
figure()
for i = 1:3
    semilogy(stress, strain_rate(i,:))
    %loglog(stress, strain_rate(i,:))
    hold on
end
legend('1700K', '1810K', '1940K')
xlabel('Stress (MPa)')
ylabel('Strain Rate')

logstrain_rate = log10(strain_rate);
logstress = log10(stress);

% evaluate and plot the derivative in loglog space as this should give the
% n value which will allow visualization of creep mechanism regimes
dydx_1700k = diff([eps; logstrain_rate(1,:)'])./diff([eps; logstress(:)]);                  % remove eps
dydx_1810k = diff([eps; logstrain_rate(2,:)'])./diff([eps; logstress(:)]);
dydx_1940k = diff([eps; logstrain_rate(3,:)'])./diff([eps; logstress(:)]);
figure()
plot(stress, dydx_1700k)
hold on
plot(stress, dydx_1810k)
plot(stress, dydx_1940k)
legend('1700K', '1810K', '1940K')
xlabel('Stress (MPa)')
ylabel('n value')

% b) NH or Coble creep in diffusional region?
% so = [10];
% fit_params = fminsearch(@lsfit, so);
% figure()
% plot(stress(1:4), strain_rate_1700k(1:4))
% hold on
% plot(stress(1:4), fit_params(1)*(1/10e-6)^3*stress(1:4))
% legend('Data', 'Fit')

% function s = lsfit(Ac)
% global strain_rate_1700k
%     s = sum((strain_rate_1700k(1:4) - Ac*(1/10e-6)^3)).^2;
% end

%% Problem 2
% initialization
global omega d G b k 
% given in problem statement
omega = 1.2e-29;                % atomic volume (m^3/atom)               
DoL = 3.5e-6;                   % lattice diffusion constant - also used in PLC according to 10/3 lecture (m^2/s)
QL = 2e-19;                     % not described, assume this comprises the value Qm+Qf given on pg 102 (J/atom)               
d = 1e-5;                       % grain size (m)
DoC = 1e-5;                     % coble creep diffusion coefficient (m^2/s)
Qc = 1.2e-19;                   % not described, assume this comprises the value Qm+Qf given in eq 5.41 (J/atom)
Apl = 2.5e9;                    % A for PLC 
mpl = 4.8;                      % stress exponent for PLC
G = 25e9;                       % shear modulus for aluminm (Pa)
b = 0.286e-9;                   % burger's vector (m)

% additional constants 
k = 1.38e-23;   % boltzmann constant
Anh = 7;        % A for Nabarro-Herring from Table 5.1
Ac = 50;        % A for coble creep from Table 5.1
n_nh = 2;       % n for NH from Table 5.1
n_c = 3;        % n for coble from Table 5.1 

% regimes of interest
temp = [600:100:1000];          % temp (K)
stress = 1e6*[1 3 10 30 100];       % stress (MPa)

% likely have to use a for loop to loop through all possible combinations,
% finding the fastest creep rate at each
%strain_rate_pl = Apl*sigma.^npl.*exp(-Qc./(R.*Temp))
%strain_rate_nh = Anh*DoL*exp(*(1/d^2)*sigma*omega/(k*T)
figure()
for i = 1:length(temp)
    T =  temp(i);
    for j = 1:length(stress)
        sigma = stress(j);
        % pl creep
        strain_rate_pl(i,j) = uni_creep_eq(Apl, DoL, QL, sigma, mpl, T, 0);
        % coble creep
        strain_rate_c(i,j) = uni_creep_eq(Ac, DoC, Qc, sigma, 0, T, n_c);
        % NH creep
        strain_rate_nh(i,j) = uni_creep_eq(Anh, DoL, QL, sigma, 0, T, n_nh);
        % total strain_rate
        strain_rate = [strain_rate_pl(i,j) strain_rate_c(i,j) strain_rate_nh(i,j)];
        [max_strain_rate(i,j), mechanism(i,j)] = max(strain_rate);

        
    end
    group(mechanism(i,:) == 1) = {'Power Law Creep'};
    group(mechanism(i,:) == 2) = {'Coble Creep'};
    group(mechanism(i,:) == 3) = {'NH Creep'};
    gscatter(T*ones(length(stress),1), log10(stress./G), {group})
    hold on
end
xlabel('Temperature')
ylabel('Log(sigma/G)')
title('Dominant Creep Mechanism')

% part b
T = 475+273;    % temp (K)
strain_rate = 0.01/(1000*3600);
% solve for the sigma at this desired strain rate - which mechanism? 
% looking at the max strain rates determined in part a, all calculated
% strain rates are far higher than the desired strain rate. To acheive the
% desired strain rate, the stress must be much lower than any of the values
% used in calculating this chart.  Therefore, we can rule out PLC. NH seems to dominate 
% at low stress levels.  Calculating the stress to give the desired creep rate, assuming NH
% yields a stress.  We can calculate strain rates at that stress to confirm
% that indeed NH gives the maximum strain rate at this stress.  And to be
% certain, calculating the stress to give the desired creep rate, assuming
% Coble yields a stress.  At this calculated stress, however, NH mechanism
% still dominates.  Therefore we should use the stress from the NH
% calculation.  

% sigma_t_pl = (strain_rate/(Apl*DoL*exp(QL/(k*T)))*omega^(2/3)*(G^mpl)*k*T/omega)^(1/mpl);
sigma_t_c = strain_rate/(Ac*DoC*exp(Qc/(k*T)))*omega^(2/3)*k*T/omega*(d/b)^n_c;
sigma_t_nh = strain_rate/(Anh*DoL*exp(QL/(k*T)))*omega^(2/3)*k*T/omega*(d/b)^n_nh;

sigma_t = [sigma_t_c sigma_t_nh]
        % coble creep
        strain_rate_c = uni_creep_eq(Ac, DoC, Qc, sigma_t(1), 0, T, n_c);
        % NH creep
        strain_rate_nh = uni_creep_eq(Anh, DoL, QL, sigma_t(1), 0, T, n_nh);
        strain_rate = [strain_rate_c strain_rate_nh];
        [max_strain_rate, mechanism] = max(strain_rate);
        if mechanism == 2
            disp(['NH creep. Sigma = ', num2str(sigma_t_nh)])
        end

% universal creep equation
function strain_rate = uni_creep_eq(A,D,Q,sigma,m,T,n)
    global omega d G b k 
    D_t = D*exp(Q/(k*T));
    strain_rate = A*D_t/(omega^(2/3))*((sigma/G)^m)*((sigma*omega)/(k*T))*(b/d)^n;
end
