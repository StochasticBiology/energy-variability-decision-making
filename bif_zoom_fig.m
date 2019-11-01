%font, fontsize and figure size
wd=8;ht=7;
fn='Helvetica';
% fs_labels=10;
fs_axis=9;

%output directory for figure
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\figures'; % PC
% figuresDirectory =
% '\Users\rdk316\Dropbox\PhD\publications\energy_variability_decision_making\manuscript\figures\new_figs-25apr\latex\bif-diagrams\figs'; % Mac

%data files directory location
dataFilesDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\data-files';
%%
a=1;b=0.5;k=1;

A_star_lower = 0.48;
A_star_upper = 0.54;

csvFileName = sprintf('%s\\unique-steady-states-bif-b-zoom.csv', dataFilesDirectory);
T = readtable(csvFileName);

T_2a = T(T.a == a, :);
T_2b = T_2a(T_2a.b == b, :);
T_2c = T_2b(T_2b.k == k, :);

% linspace(A_star_lower,A_star_upper,((A_star_upper-A_star_lower)/0.01)+1)

quenchedTable = T_2c;
sizeQuenchedTable = size(quenchedTable);
	
%creating fig#ure
fig1=figure('Name','bifurcation_zoom_b');

%plotting sub-figre 
xlim([A_star_lower A_star_upper]);hold on;ylim([0 1]);grid on;box on;%axes limits & box around figure
%hx=xlabel('$A^{*}$','interpreter','latex');hx.FontSize=fs_labels;hx.FontName=fn;%label on x-axis
%hy=ylabel('$x_{2}$-Position of Fixed Points','interpreter','latex');hy.FontSize=fs_labels;hy.FontName=fn;%label on y-axis
ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = A_star_lower:0.01:A_star_upper;%changing x and y axes properties
fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];%setting figure size
i=1;
	while i <= sizeQuenchedTable(1)
% 		disp(i);
		if strcmp(quenchedTable.Stability{i},'Stable') == 1
			plot(quenchedTable.Energy(i), quenchedTable.SteadyStateX2(i),'b.','MarkerSize',3);
		else
			plot(quenchedTable.Energy(i), quenchedTable.SteadyStateX2(i),'r.','MarkerSize',3);
		end
		i=i+1;
	end
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName = sprintf('bif_a=%.0f_b=%.0f_zoom.svg',a*100, b*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig1,fullFileName,'-dsvg');

%%
a=3;b=1;k=1;

A_star_lower = 0.4;
A_star_upper = 0.46;

csvFileName2 = sprintf('%s\\unique-steady-states-bif-a-zoom.csv', dataFilesDirectory);
T = readtable(csvFileName2);

T_2a = T(T.a == a, :);
T_2b = T_2a(T_2a.b == b, :);
T_2c = T_2b(T_2b.k == k, :);

quenchedTable = T_2c;
sizeQuenchedTable = size(quenchedTable);
	
%creating fig#ure
fig2=figure('Name','bifurcation_zoom_a');

%plotting sub-figre 
xlim([A_star_lower A_star_upper]);hold on;ylim([0 1.5]);grid on;box on;%axes limits & box around figurees
%hx=xlabel('$A^{*}$','interpreter','latex');hx.FontSize=fs_labels;hx.FontName=fn;%label on x-axis
%hy=ylabel('$x_{2}$-Position of Fixed Points','interpreter','latex');hy.FontSize=fs_labels;hy.FontName=fn;%label on y-axis
ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = A_star_lower:0.01:A_star_upper;ax.YTick = 0:0.25:1.5;%changing x and y axes properties
fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];%setting figure size
j=1;
	while j <= sizeQuenchedTable(1)
% 		disp(i);
		if strcmp(quenchedTable.Stability{j},'Stable') == 1
			plot(quenchedTable.Energy(j), quenchedTable.SteadyStateX2(j),'b.','MarkerSize',3);
		else
			plot(quenchedTable.Energy(j), quenchedTable.SteadyStateX2(j),'r.','MarkerSize',3);
		end
		j=j+1;
	end
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName2 = sprintf('bif_a=%.0f_b=%.0f_zoom.svg',a*100, b*100);fullFileName2=fullfile(figuresDirectory, figureFileName2);print(fig2,fullFileName2,'-dsvg');