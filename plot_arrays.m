%font, fontsize and figure size
fn='Helvetica';
wd=16;ht=14;
fs_labels=15;fs_axis=12;fs_sub_title=13;

%output directory for figure - modify individually
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\svg-figures'; % PC

%data files directory location - modify individually
dataFilesDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\data-files'; % PC

%% steady state array for a=1, b=0.25, A_star = [0.4 0.5 0.6 0.7].
% fixed parameter values
a=1;b=0.25;

%import data
csvFileName = sprintf('%s\\sigmoid-n4-unique-steady-states.csv', dataFilesDirectory);
T = readtable(csvFileName);

% sub-table for fixed parameter values
subTable = T((T.a == a & T.b==b),:);

% create array figure
figure_name = sprintf('array_atp_a=%.0f_b=%.0f',a*100,b*100);
array_fig=figure('Name',figure_name,'Visible', 'off');
set(gcf,'Units','centimeters','Position',[0 0 wd ht],...
    'PaperUnits','centimeters','PaperSize',[wd ht]);
p=0;

%loop through A* values
for A_star = [0.4 0.5 0.6 0.7]
    p=p+1;
    
    %quench table to current parameter set
    col_energy = subTable(:,6);
    quenchedTable = subTable(subTable.Energy == A_star,:);
	sizeQuenchedTable = size(quenchedTable);
	
    %plot sub-figures
	subplot(2,2,p);
	grid on;hold on;box on;
	ax = gca;ax.XTick = 0:1:3;ax.YTick = 0:1:3;ax.YLim = [0 3];ax.XLim = [0 3];
    ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';
	i=1;
	while i <= sizeQuenchedTable(1)% plot stable and unstable points
		if strcmp(quenchedTable.Stability{i},'Stable') == 1
			plot(quenchedTable.SteadyStateX1(i), quenchedTable.SteadyStateX2(i), 'bo','MarkerSize',4,'MarkerFaceColor','b');
		else
			plot(quenchedTable.SteadyStateX1(i), quenchedTable.SteadyStateX2(i), 'ro','MarkerSize',4,'MarkerFaceColor','r');
		end
		i=i+1;
	end
	hold off;
end

%save figure to output directory with specified name and file extenstion
figureFileName = sprintf('array_atp_a=%.0f_b=%.0f.svg',a*100,b*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(array_fig,fullFileName,'-dsvg');

%% steady state array for a=1.5, A_star=0.5, b = [0 0.25 0.5 0.75].
% fixed parameter values
a=1.5;A_star=0.5;

% create array figure
figure_name = sprintf('array_b_a=%.0f_energy=%.0f',a*100,A_star*100);
array_fig=figure('Name',figure_name,'Visible', 'off');
set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);

% sub-table for fixed parameter values
subTable2 = T((T.a == a & T.Energy==A_star),:);
p=0;
    
for b = [0 0.25 0.5 0.75]
    p=p+1;
    
    %quench table to current parameter set
	col_b = subTable(:,2);
    quenchedTable2 = subTable2(subTable2.b == b,:);%new matrix B_3 is a submatrix of B_2 with value b in the second column
	sizeQuenchedTable2 = size(quenchedTable2);
	
    %plot sub-figures
	subplot(2,2,p);
	grid on;hold on;box on;
	ax = gca;ax.XTick = 0:0.5:2;ax.YTick = 0:0.5:2;ax.YLim = [0 2];ax.XLim = [0 2];
    ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';
	j=1;
	while j <= sizeQuenchedTable2(1)% plot stable and unstable points
		if strcmp(quenchedTable2.Stability{j},'Stable') == 1
			plot(quenchedTable2.SteadyStateX1(j), quenchedTable2.SteadyStateX2(j), 'bo','MarkerSize',4,'MarkerFaceColor','b');
		else
			plot(quenchedTable2.SteadyStateX1(j), quenchedTable2.SteadyStateX2(j), 'ro','MarkerSize',4,'MarkerFaceColor','r');
		end
		j=j+1;
	end
	hold off;
end

%save figure to output directory with specified name and file extenstion
figureFileName = sprintf('array_b_a=%.0f_energy=%.0f.svg',a*100,A_star*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(array_fig,fullFileName,'-dsvg');
