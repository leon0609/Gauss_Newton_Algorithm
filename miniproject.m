%Input the data.
t=[1:8]';
y=[8.0 12.3 15.5 16.8 17.1 15.8 15.2 14.0];
c = [4; 1];   % The initial value of c1 and c2

%Define the functions f = c1*t*exp(c2*t).
f = @(c) c(1).*t.*exp(c(2).*t);
% Define a function of the jac of the residue r(c) = y' - f(c)
J = @(c) [-t.*exp(c(2).*t), -c(1).*(t.^2).*exp(c(2).*t)];
r = @(c) y' - f(c); %Residue
for i = 1:30                    % Apply Gauss_Newton Method.
    A = J(c);                   % A = Dr(x^k).
    v = (A' * A) \ (-A' * r(c)); % (A' * A) * v^k = -A' * r(x^k).
    c = c + v;                  % c^(k+1) = c^k + v^k.
end
%Get the coefficient of c1 and c2 and find the RMSE
c1 = c(1)
c2 = c(2)
RMSE = norm(r(c),2)./sqrt(length(r(c))); %By definition
%Plot them!
tfit = [linspace(1,8,50)]';
yfit = c(1).*tfit.*exp(c(2).*tfit);
hold on
plot(tfit,yfit)
plot(t,y,'ro')
str = ['RMSE= ',RMSE];
title(str)
legend('fit value','real value')