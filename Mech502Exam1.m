%% Exam 1
%% Problem 2
stress = [0.42 0.76 1.15 2.0 2.6 3.2 3.9 4.6 6.2 7.1 8.2];
strain = [0.02 0.04 0.06 0.1 0.14 0.16 0.19 0.22 0.27 0.30 0.33];

strain_e = exp(strain) -  1;
stress_e = stress.*(1./(1-strain));   % Note L = Lo-strain as rubber is in compression
figure()
plot(strain, stress)
title('Stress-Strain Behavior of Rubber in Compression')
hold on
plot(strain_e, stress_e, ':bs')
xlabel('Strain')
ylabel('Stress')
legend('True stress', 'Engineering Stress')

%% Problem 3
d = [15 20 36 96];  % twin spacing
n = [0.36 0.33 0.27 0.22];  % strain-hardening exponent

plot(d,n)
title('Effect of twin spacing')
xlabel('Twin spacing')
ylabel('Necking Strain')