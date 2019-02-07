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

% universal creep equation
function strain_rate = uni_creep_eq(A,D,Q,sigma,m,T,n)
    global omega d G b k 
    D_t = D*exp(Q/(k*T));
    strain_rate = A*D_t/(omega^(2/3))*((sigma/G)^m)*((sigma*omega)/(k*T))*(b/d)^n;
end
