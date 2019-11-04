%% script compiles bifurcation diagrams when varying a, b or k for narrow regions of A*.

%font, fontsize and figure size
wd=8;ht=7;
fn='Helvetica';
fs_axis=9;

%output directory for figure - modify individually
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\svg-figures'; % PC

%data files directory location - modify individually
dataFilesDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\data-files'; % PC
%% bifurcation diagrams for a=1, b=0.5, k=1 & A* = [0.48, 0.54]
%fixed parameters
a=1;b=0.5;k=1;

%A* range
A_star_lower = 0.48;
A_star_upper = 0.54;

% import data
csvFileName = sprintf('%s\\bif-b-zoom-unique-steady-states.csv', dataFilesDirectory);
T = readtable(csvFileName);

%quench table to specific parameter set
T_2a = T(T.a == a, :);
T_2b = T_2a(T_2a.b == b, :);
quenchedTable = T_2b(T_2b.k == k, :);
sizeQuenchedTable = size(quenchedTable);
	
%create bifurcation diagram
fig1=figure('Name','bifurcation_zoom_b','Visible','off');
xlim([A_star_lower A_star_upper]);hold on;ylim([0 1]);grid on;box on;
ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = A_star_lower:0.01:A_star_upper;
fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];
i=1;
	while i <= sizeQuenchedTable(1)% plot stable and unstable points
		if strcmp(quenchedTable.Stability{i},'Stable') == 1
			plot(quenchedTable.Energy(i), quenchedTable.SteadyStateX2(i),'b.','MarkerSize',3);
		else
			plot(quenchedTable.Energy(i), quenchedTable.SteadyStateX2(i),'r.','MarkerSize',3);
		end
		i=i+1;
	end
hold off;

%save figure to output directory with specified name and file extenstion
figureFileName = sprintf('bif_zoom_a=%.0f_b=%.0f.svg',a*100, b*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig1,fullFileName,'-dsvg');

%clear some of the information stored by matlab - valuable if full code file is executed.
param={'T','quenchedTable','a','b','k'};clear(param{:});

%% bifurcation diagrams for a=3, b=1, k=1 & A* = [0.4, 0.46]
%fixed parameters
a=3;b=1;k=1;

%A* range
A_star_lower = 0.4;
A_star_upper = 0.46;

% import data
csvFileName2 = sprintf('%s\\bif-a-zoom-unique-steady-states.csv', dataFilesDirectory);
T = readtable(csvFileName2);

%quench table to specific parameter set
T_2a = T(T.a == a, :);
T_2b = T_2a(T_2a.b == b, :);
quenchedTable = T_2b(T_2b.k == k, :);
sizeQuenchedTable = size(quenchedTable);
	
%create bifurcation diagram
fig2=figure('Name','bifurcation_zoom_a','Visible','off');
xlim([A_star_lower A_star_upper]);hold on;ylim([0 1.5]);grid on;box on;
ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = A_star_lower:0.01:A_star_upper;ax.YTick = 0:0.25:1.5;
fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];
j=1;
	while j <= sizeQuenchedTable(1)% plot stable and unstable points
		if strcmp(quenchedTable.Stability{j},'Stable') == 1
			plot(quenchedTable.Energy(j), quenchedTable.SteadyStateX2(j),'b.','MarkerSize',3);
		else
			plot(quenchedTable.Energy(j), quenchedTable.SteadyStateX2(j),'r.','MarkerSize',3);
		end
		j=j+1;
	end
hold off;

%save figure to output directory with specified name and file extenstion
figureFileName2 = sprintf('bif_zoom_a=%.0f_b=%.0f.svg',a*100, b*100);fullFileName2=fullfile(figuresDirectory, figureFileName2);print(fig2,fullFileName2,'-dsvg');