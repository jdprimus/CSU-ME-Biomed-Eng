sigma = [0 141 202 252 290 319 343 360 373 390];
epsilon = [0.00 0.087 0.172 0.259 0.339 0.413 0.482 0.547 0.608 0.770];
plot(epsilon, sigma)

% initial model selection: Holloman
% justification: simplest model to fit (least parameters), and the curve
% starts at the origin

sigma_t = k*epsilon_t^n;
s = sum(sigma - (k*epsilon^n))^2;