%% script checks stability of steady states using the jacobian

%set the parameter values
a=1.5;b=3;
n=4;
k=1;
theta_A=0.5;theta_B=0.5;

%A* value
A_star=0.8;

%steady state
steadystate=[0.39, 3.546];

%lambda, if linear function is chosen
% l= @(A_star) A_star;
%lambda, if sigmoid function is chosen
l= @(A_star) 1./(1+exp(-(16*A_star-8)));

%symbolic variables
syms x1 x2;
%symbolic ODEs
ODEs=[l(A_star)*a*x1^n./(theta_A^n+x1^n)+l(A_star)*b*theta_B^n./(theta_B^n+x2^n)-k*x1;...
    l(A_star)*a*x2^n./(theta_A^n+x2^n)+l(A_star)*b*theta_B^n./(theta_B^n+x1^n)-k*x2];

%calculate jacobian and eigenvalues
variables=[x1,x2];
jac=jacobian(ODEs,variables); 
sub=subs(jac, [x1 x2], steadystate);
eigenvalues = eig(sub);
eigen_sign=([sign(eigenvalues(1)),sign(eigenvalues(2))]);

%display sign of both eigenvalues in command window
if (eigen_sign(1) && eigen_sign(2) < 0)
    disp('Steady state is STABLE');
else
    disp('Steady state is UNSTABLE');
end

