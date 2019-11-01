%universal value
fn='Helvetica';wd=16;ht=14;fs_labels=15;fs_axis=12;fs_sub_title=13;

%output directory for figure
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\figures'; % PC
% figuresDirectory =
% '\Users\rdk316\Dropbox\PhD\publications\energy_variability_decision_making\manuscript\figures\new_figs-25apr\latex\bif-diagrams\figs'; % Mac

%data files directory location
dataFilesDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\data-files';

%%
a=1;b=0.25;

csvFileName = sprintf('%s\\unique-steady-states-n4.csv', dataFilesDirectory);
T = readtable(csvFileName);
FinalTable = T((T.a == a & T.b==b),:);
columnHeaders = T.Properties.VariableNames;

a_col = FinalTable(:,1);
b_col = FinalTable(:,2);
k_col = FinalTable(:,3);
energy_col = FinalTable(:,6);

figure_name = sprintf('array_atp_a=%.0f_b=%.0f',a*100,b*100);
array_fig=figure('Name',figure_name);
set(gcf,'Units','centimeters','Position',[0 0 wd ht],...
    'PaperUnits','centimeters','PaperSize',[wd ht]);
p=0;

for A_star = [0.4 0.5 0.6 0.7]
    p=p+1;
    
    col_energy = energy_col;%selecting a column in B_2 matrix
    quenchedTable = FinalTable(FinalTable.Energy == A_star,:);%new matrix B_3 is a submatrix of B_2 with value b in the second column
	sizeQuenchedTable = size(quenchedTable);
	
	subplot(2,2,p);
	grid on;hold on;box on; %axes limits & box around figure
	ax = gca;ax.XTick = 0:1:3;ax.YTick = 0:1:3;ax.YLim = [0 3];ax.XLim = [0 3];
    ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';%ax.XTickLabel=[];ax.YTickLabel=[];
% 	hx=xlabel('$x_1$');hx.Interpreter='latex';hx.FontSize=fs_labels;hx.FontName=fn;%x-a[xis
%     hy=ylabel('$x_2$');hy.Interpreter='latex';hy.FontSize=fs_labels;hy.FontName=fn;%y-axis
%     sub_tit=title(sprintf('$A^{*} = %.2f$',A_star)); %changing title within for loop for value of ATP used in calculations
%     sub_tit.FontName=fn;sub_tit.FontWeight='normal';sub_tit.FontSize=fs_sub_title;sub_tit.Interpreter='latex';%fs_axis;
	i=1;
	while i <= sizeQuenchedTable(1)
		if strcmp(quenchedTable.Stability{i},'Stable') == 1
			plot(quenchedTable.SteadyStateX1(i), quenchedTable.SteadyStateX2(i), 'bo','MarkerSize',4,'MarkerFaceColor','b');
		else
			plot(quenchedTable.SteadyStateX1(i), quenchedTable.SteadyStateX2(i), 'ro','MarkerSize',4,'MarkerFaceColor','r');
		end
		i=i+1;
	end
	hold off;
end

%saving produced figure to output directory with specified name and file extenstion
figureFileName = sprintf('array_atp_a=%.0f_b=%.0f.svg',a*100,b*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(array_fig,fullFileName,'-dsvg');

%%

a=1.5;A_star=0.5;

figure_name = sprintf('array_b_a=%.0f_energy=%.0f',a*100,A_star*100);
array_fig=figure('Name',figure_name);
set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);

FinalTable2 = T((T.a == a & T.Energy==A_star),:);
p=0;
    
for b = [0 0.25 0.5 0.75]
    p=p+1;
    
	col_b = b_col;%selecting a column in B_2 matrix
    quenchedTable2 = FinalTable2(FinalTable2.b == b,:);%new matrix B_3 is a submatrix of B_2 with value b in the second column
	sizeQuenchedTable2 = size(quenchedTable2);
	
	subplot(2,2,p);
	grid on;hold on;box on;
	ax = gca;ax.XTick = 0:0.5:2;ax.YTick = 0:0.5:2;ax.YLim = [0 2];ax.XLim = [0 2];
    ax.FontSize=fs_axis;ax.FontName=fn;ax.TickDir = 'out';%ax.XTickLabel=[];ax.YTickLabel=[];
%     hx=xlabel('$x_1$');hx.Interpreter='latex';hx.FontSize=fs_labels;hx.FontName=fn;%x-axis
%     hy=ylabel('$x_2$');hy.Interpreter='latex';hy.FontSize=fs_labels;hy.FontName=fn;%y-axis
%     sub_tit=title(sprintf('$b = %.2f$',b)); %changing title within for loop for value of ATP used in calculations
%     sub_tit.FontName=fn;sub_tit.FontWeight='normal';sub_tit.FontSize=fs_sub_title;sub_tit.Interpreter='latex';%fs_axis;
	i=1;
	while i <= sizeQuenchedTable2(1)
		if strcmp(quenchedTable2.Stability{i},'Stable') == 1
			plot(quenchedTable2.SteadyStateX1(i), quenchedTable2.SteadyStateX2(i), 'bo','MarkerSize',4,'MarkerFaceColor','b');
		else
			plot(quenchedTable2.SteadyStateX1(i), quenchedTable2.SteadyStateX2(i), 'ro','MarkerSize',4,'MarkerFaceColor','r');
		end
		i=i+1;
	end
	hold off;
end

%saving produced figure to output directory with specified name and file extenstion
figureFileName = sprintf('array_b_a=%.0f_energy=%.0f.svg',a*100,A_star*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(array_fig,fullFileName,'-dsvg');
