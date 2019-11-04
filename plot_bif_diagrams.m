%% script compiles bifurcation diagrams when varying a, b or k.

%font, fontsize and figure size
wd=8;ht=7;
fn='Helvetica';
fs_axis=9;

%output directory for figure - modify individually
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\svg-figures'; % PC

%data files directory location - modify individually
dataFilesDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\data-files'; % PC
%% bifurcation diagrams for different values of b
% import data
csvFileName = sprintf('%s\\bif-b-unique-steady-states.csv', dataFilesDirectory);
T = readtable(csvFileName);

%loop through b
for b=[0.25,0.5,0.75,1.5]
	
    %quench table to current parameter set
	quenchedTable = T(T.b == b,:);
	sizeQuenchedTable = size(quenchedTable);
    
    %create bifurcation diagram
    fig1=figure('Name','Bifurcation_b','Visible','off');
    xlim([0 1]);hold on;ylim([0 3]);grid on;box on;%axes limits & box around figure
    ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = 0:0.2:1;ax.YTick = 0:1:3;%changing x and y axes properties
    fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];%setting figure size
    i=1;
	while i <= sizeQuenchedTable(1) % plot stable and unstable points
		if strcmp(quenchedTable.Stability{i},'Stable') == 1
			plot(quenchedTable.Energy(i), quenchedTable.SteadyStateX2(i),'b.','MarkerSize',1.5);
		else
			plot(quenchedTable.Energy(i), quenchedTable.SteadyStateX2(i),'r.','MarkerSize',1.5);
		end
		i=i+1;
	end
	hold off;
    
    %save figure to output directory with specified name and file extenstion
    figureFileName = sprintf('bif_b=%.0f.svg',b*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig1,fullFileName,'-dsvg');
end

%clear some of the information stored by matlab - valuable if full code file is executed.
param={'T','a','b','k'};clear(param{:});

%% bifurcation diagrams for different values of a
% import data
csvFileName = sprintf('%s\\bif-a-unique-steady-states.csv', dataFilesDirectory);
T = readtable(csvFileName);

%loop through a
for a=[0, 0.25,1,1.25,1.75,3]
	
    %quench table to current parameter set
	quenchedTable2 = T(T.a == a,:);
	sizeQuenchedTable2 = size(quenchedTable2);
    
	%create bifurcation diagram
    fig2=figure('Name','Bifurcation_a','Visible','off');
	xlim([0 1]);hold on;ylim([0 4]);grid on;box on;
    ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = 0:0.2:1.0;ax.YTick = 0:1:4;
    fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];
	j=1;
	while j <= sizeQuenchedTable2(1) % plot stable and unstable points
		if strcmp(quenchedTable2.Stability{j},'Stable') == 1
			plot(quenchedTable2.Energy(j), quenchedTable2.SteadyStateX2(j),'b.','MarkerSize',2.5);
		else
			plot(quenchedTable2.Energy(j), quenchedTable2.SteadyStateX2(j),'r.','MarkerSize',2.5);
		end
		j=j+1;
	end
	hold off;
    
    %save figure to output directory with specified name and file extenstion
    figureFileName = sprintf('bif_a=%.0f.svg',a*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig2,fullFileName,'-dsvg');
end

%clear some of the information stored by matlab.
param={'T','a','b','k'};clear(param{:});
%% bifurcation diagrams for different values of k
% import data
csvFileName = sprintf('%s\\bif-k-unique-steady-states.csv', dataFilesDirectory);
T = readtable(csvFileName);

%loop through k
for k=[0.5,1.25,1.5,3]
	
    %quench table to current parameter set
	quenchedTable3 = T(T.k == k,:);
	sizeQuenchedTable3 = size(quenchedTable3);
	
	%create bifurcation diagram
    fig3=figure('Name','Bifurcation_k','Visible','off');
	xlim([0 1]);hold on;ylim([0 4]);grid on;box on;
    ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = 0:0.2:1.0;ax.YTick = 0:1:4;
    fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];
	l=1;
	while l <= sizeQuenchedTable3(1) % plot stable and unstable points
		if strcmp(quenchedTable3.Stability{l},'Stable') == 1
			plot(quenchedTable3.Energy(l), quenchedTable3.SteadyStateX2(l),'b.','MarkerSize',2.5);
		else
			plot(quenchedTable3.Energy(l), quenchedTable3.SteadyStateX2(l),'r.','MarkerSize',2.5);
		end
		l=l+1;
	end
	hold off;
    
    %save figure to output directory with specified name and file extenstion
    figureFileName = sprintf('bif_k=%.0f.svg',k*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig3,fullFileName,'-dsvg');
end
