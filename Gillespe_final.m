% Gillespe Algorithm for probabilistic evolution of antibiotic resistance 
% Jeremy Primus
% May 5, 2017

% Reaction scheme
%   A -k1-> A + A
%   A -r-> A + X
%   X -k2-> X + X
%   A -d1-> null
%   X -d2-> null

clear t X h;
k1 = 0.0020;
r = 0.0002;
k2 = k1/2;
d1 = 0.0030;
d2 = 0.0005;
c = [k1 r k2 d1 d2]; % probability coefficients
A = 1000;
X = 0;
sp = [A; X]; % species quantities
s = 0;
t = 0;
proceed = true;
while proceed
    s = s + 1;
    h = [sp(1) sp(1) sp(2) sp(1) sp(2)];
    a = c.*h; % calculate probability per unit time of uth reaction

    ao = sum(a);

    r(1) = rand;
    tau = (1/ao)*log(1/r(1));
    t(s+1) = t(s) + tau;
    t(s+1)
    r(2) = rand;
    
    if r(2) < (a(1)/ao)
        sp(1) = sp(1) + 1;
    elseif r(2) > (a(1)/ao) && r(2) <= (sum(a(1:2))/ao)
        sp(2) = sp(2) + 1;
    elseif r(2) > (sum(a(1:2))/ao) && r(2) <= (sum(a(1:3))/ao)
        sp(2) = sp(2) + 1;
    elseif r(2) > (sum(a(1:3))/ao) && r(2) <= (sum(a(1:4))/ao)
        sp(1) = sp(1) - 1;
    elseif r(2) > (sum(a(1:4))/ao) && r(2) <= (ao/ao)
        sp(2) = sp(2) - 1;
    end
        X(1:2,s+1) = sp(1:2);
    
    if t(s) > 3500.0 || sp(1) == 0 
        proceed = false;
    end
end
plot(t, X)
hold on
