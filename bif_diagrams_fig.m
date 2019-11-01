%%%this script displays executable code with comments to explain the function of the line of code next to or below it.
%%%comments are included for inhibition bifurcation diagrams and are very similar for activation and degradation bifurcation diagrams.

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
%% bifurcation diagram with b
a=1;
% import all data from csv file
csvFileName = sprintf('%s\\unique-steady-states-bif-b.csv', dataFilesDirectory);
T = readtable(csvFileName);
subTable = T(T.a == a,:);
%b values to scan through
for b=[0.25,0.5,0.75,1.5]
	
	quenchedTable = subTable(subTable.b == b,:);
	sizeQuenchedTable = size(quenchedTable);
    
    %creating bifurcation figure
    fig1=figure('Name','Bifurcation_b','Visible','off');
    
	%plotting sub-figre
    xlim([0 1]);hold on;ylim([0 3]);grid on;box on;%axes limits & box around figure
    %hx=xlabel('$A^{*}$','interpreter','latex');hx.FontSize=fs_labels;hx.FontName=fn;%label on x-axis
    %hy=ylabel('$x_{2}$-Position of Fixed Points','interpreter','latex');hy.FontSize=fs_labels;hy.FontName=fn;%label on y-axis
    ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = 0:0.2:1;ax.YTick = 0:1:3;%changing x and y axes properties
    fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];%setting figure size
    i=1;
	while i <= sizeQuenchedTable(1)
% 		disp(i);
		if strcmp(quenchedTable.Stability{i},'Stable') == 1
			plot(quenchedTable.Energy(i), quenchedTable.SteadyStateX2(i),'b.','MarkerSize',1.5);
		else
			plot(quenchedTable.Energy(i), quenchedTable.SteadyStateX2(i),'r.','MarkerSize',1.5);
		end
		i=i+1;
	end
	hold off;
    
    %saving produced figure to output directory with specified name and file extenstion
    figureFileName = sprintf('bif_b=%.0f.svg',b*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig1,fullFileName,'-dsvg');
end

%clear some of the information stored by matlab - valuable if full code file is executed.
param={'T','a','b','k'};clear(param{:});


%% bifurcation diagram with a
b=1;
% import all data from csv file
csvFileName = sprintf('%s\\unique-steady-states-bif-a.csv', dataFilesDirectory);
T = readtable(csvFileName);
subTable2 = T(T.b == b,:);

for a=[0, 0.25,1,1.25,1.75,3]
	
	quenchedTable2 = subTable2(subTable2.a == a,:);
	sizeQuenchedTable2 = size(quenchedTable2);
    
	%creating bifurcation figure
    fig2=figure('Name','Bifurcation_a','Visible','off');
	
	xlim([0 1]);hold on;ylim([0 4]);grid on;box on;
    %hx=xlabel('$A^{*}$','interpreter','latex');hx.FontSize=fs_labels;hx.FontName=fn;
    %hy=ylabel('$x_{2}$-Position of Fixed Points','interpreter','latex');hy.FontSize=fs_labels;hy.FontName=fn;
    ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = 0:0.2:1.0;ax.YTick = 0:1:4;
    fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];
	j=1;
	while j <= sizeQuenchedTable2(1)
% 		disp(i);
		if strcmp(quenchedTable2.Stability{j},'Stable') == 1
			plot(quenchedTable2.Energy(j), quenchedTable2.SteadyStateX2(j),'b.','MarkerSize',2.5);
		else
			plot(quenchedTable2.Energy(j), quenchedTable2.SteadyStateX2(j),'r.','MarkerSize',2.5);
		end
		j=j+1;
	end
	hold off;
    
    %saving produced figure to output directory with specified name and file extenstion
    figureFileName = sprintf('bif_a=%.0f.svg',a*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig2,fullFileName,'-dsvg');
end
% % 
%clear some of the information stored by matlab - valuable if full code file is executed.
param={'T','a','b','k'};clear(param{:});
%% bifurcation diagram with k
a=1;b=1;
% import all data from csv file
csvFileName = sprintf('%s\\unique-steady-states-bif-k.csv', dataFilesDirectory);
T = readtable(csvFileName);
subTable3a = T(T.a == a,:);
subTable3b = subTable3a(subTable3a.b == b,:);

for k=[0.5,1.25,1.5,3]
	
	quenchedTable3 = subTable3b(subTable3b.k == k,:);
	sizeQuenchedTable3 = size(quenchedTable3);
	
	%creating bifurcation figure
    fig3=figure('Name','Bifurcation_k','Visible','off');
	
	xlim([0 1]);hold on;ylim([0 4]);grid on;box on;
    %hx=xlabel('$A^{*}$','interpreter','latex');hx.FontSize=fs_labels;hx.FontName=fn;
    %hy=ylabel('$x_{2}$-Position of Fixed Points','interpreter','latex');hy.FontSize=fs_labels;hy.FontName=fn;
    ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';ax.XTick = 0:0.2:1.0;ax.YTick = 0:1:4;
    fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];
	l=1;
	while l <= sizeQuenchedTable3(1)
% 		disp(i);
		if strcmp(quenchedTable3.Stability{l},'Stable') == 1
			plot(quenchedTable3.Energy(l), quenchedTable3.SteadyStateX2(l),'b.','MarkerSize',2.5);
		else
			plot(quenchedTable3.Energy(l), quenchedTable3.SteadyStateX2(l),'r.','MarkerSize',2.5);
		end
		l=l+1;
	end
	hold off;
    
    %saving produced figure to output directory with specified name and file extenstion
    figureFileName = sprintf('bif_k=%.0f.svg',k*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig3,fullFileName,'-dsvg');
end
