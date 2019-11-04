%% script compiles time-dependant examples for bifurcation diagram example.

%font, fontsize and figure size
fn='Helvetica';
wd=8;ht=7;
fs_labels=12;fs_axis=10;

%fixed parameter values
a=1;b=1;k=1;n=4;theta_a=0.5;theta_b=0.5;

%ode45 tolerances
ode_options = odeset('RelTol',1e-10,'AbsTol',1e-12);

%time range to integrate over
tspan=linspace(0,100,2000);

%output directory for figure - modify individually
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\svg-figures'; % PC

%% for each A* value uncomment correct line when saving figure (lines 79-81)
%energy levels to plot diagrams for 
A_star=0.25;%0.5;%0.8;%
%lambda
l= @(A_star) exp(16*A_star-8)/(1+exp(16*A_star-8));
%ODEs
odes = @(t,x) [l(A_star)*a*x(1)^n./(theta_a^n+x(1)^n)+l(A_star)*b*theta_b^n./(theta_b^n+x(2)^n)-k*x(1);...
                l(A_star)*a*x(2)^n./(theta_a^n+x(2)^n)+l(A_star)*b*theta_b^n./(theta_b^n+x(1)^n)-k*x(2)];
%symbolic variables 
syms x1 x2;
%symbolic ODEs
f_sym = [l(A_star)*a*x1^n./(theta_a^n+x1^n)+l(A_star)*b*theta_b^n./(theta_b^n+x2^n)-k*x1;...
    l(A_star)*a*x2^n./(theta_a^n+x2^n)+l(A_star)*b*theta_b^n./(theta_b^n+x1^n)-k*x2];
% variables for jacobian matrix
v_sym=[x1,x2];
%calculating jacobian with respect to variables x1 & x2
jac=jacobian(f_sym,v_sym);

%creating figure
fig1=figure('Visible', 'off');clf;hold on;
%loop through initial conditions mesh
for i=0:0.4:4
    for j=0:0.4:4
        %initial conditions vector
        ics=[i,j];
        %solve equations with ode45
        [t,x_num]=ode45(odes,tspan,ics,ode_options);
        %calculated steady state values
        x1_ss=x_num(2000,1);x2_ss=x_num(2000,2);
        x1_ss2=round(x1_ss,3);x2_ss2=round(x2_ss,3);

        %subs. in steady state values to jacobian
        sub=subs(jac, [x1 x2], [x1_ss x2_ss]); 
        %calc eigenvlaues
        eigen = eig(sub);
        %calculate the sign of each eigenvalue
        eigenvalue_1=sign(eigen(1));eigenvalue_2=sign(eigen(2));

        %test steady state stability
        if (eigenvalue_1 < 0) && (eigenvalue_2 < 0)
            stability = 1;
        else 
            stability = -1;
        end

        %plotting time-dependant solution if end steady state is stable
        xlim([0 15]);ylim([0 4]);grid on;box on;
        if stability == 1
             plot(t,x_num(:,2),'b');
        else
            point = 0;
        end
        ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';
        fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];
    end
end
hold off;

%save figure to output directory with specified name and file extenstion

figureFileName1 ='bif_ex_ss1.svg';fullFileName=fullfile(figuresDirectory, figureFileName1);print(fig1,fullFileName,'-dsvg'); % 1 attractor
% figureFileName2 = 'bif_ex_ss2.svg';fullFileName=fullfile(figuresDirectory, figureFileName2);print(fig1,fullFileName,'-dsvg');% 2 attractors
% figureFileName3 = 'bif_ex_ss3.svg';fullFileName=fullfile(figuresDirectory, figureFileName3);print(fig1,fullFileName,'-dsvg');% 3 attractors

