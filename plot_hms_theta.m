%% script compiles heatmap diagrams when varying thetaA, thetaB and A* with sigmoidal lambda.

%font, fontsize and figure size
wd=8;ht=7;
fn='Helvetica';
fs_labels=10;
fs_axis=9;

%output directory for figure - modify individually
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\svg-figures'; % PC

%data files directory location - modify individually
dataFilesDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\data-files'; % PC

%order of A* values for y-axis -- see use further down
NO = {'1','0.9','0.8','0.7','0.6','0.5','0.4','0.3','0.2','0.1','0'};

%% attractor quantity heatmaps

%import data
csvFileName = sprintf('%s\\thetaA-high-number-stable.csv', dataFilesDirectory);
T = readtable(csvFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%theta_A "high" values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%create heatmap figure
fig_heatmap = figure('Name','Heatmap','Visible','off');
%plotting heatmap from table T2' with b on the x-axis and energy values on the y-axis
h = heatmap(T,'thetaA','Energy','Title','','ColorVariable','NumberStableSteadyStates');
%colour scheme to use -- could use spring or summer or parula
h.Colormap = cool;
%data colour and label if missing
h.MissingDataColor = [0.8 0.8 0.8];h.MissingDataLabel = 'No data';
%method to use for displaying data
h.ColorMethod = 'none';
%color bar visible or not in figures
h.ColorbarVisible = 'off';
%fontname, colour and fontsize
h.FontColor = 'black';h.FontName = fn;h.FontSize = fs_labels;
%colour limits to keep consistency between figures
h.ColorLimits=[1 4];

%re-arranging y-axis energy values
h.SourceTable.Energy = categorical(h.SourceTable.Energy);
neworder = NO;
h.SourceTable.Energy = reordercats(h.SourceTable.Energy,neworder);

%removing y-axis label
h.YLabel=' ';
%removing x-axis label
h.XLabel=' ';
%axis fontname and fontsize
ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;
%figure size
fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];

%save figure to output directory with specified name and file extenstion
figureFileName = 'hm-vary-thetaA-high.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');
    
%% steadystate quantity heatmaps varying thetas
%import data
csvFileName = sprintf('%s\\thetaB-high-number-stable.csv', dataFilesDirectory);
T = readtable(csvFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%theta_B "high" values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%create heatmap figure
fig_heatmap = figure('Name','Heatmap','Visible','off');
%plotting heatmap from table T2' with b on the x-axis and energy values on the y-axis
h = heatmap(T,'thetaB','Energy','Title','','ColorVariable','NumberStableSteadyStates');
%colour scheme to use -- could use spring or summer or parula
h.Colormap = cool;
%data colour and label if missing
h.MissingDataColor = [0.8 0.8 0.8];h.MissingDataLabel = 'No data';
%method to use for displaying data
h.ColorMethod = 'none';
%color bar visible or not in figures
h.ColorbarVisible = 'off';
%fontname, colour and fontsize
h.FontColor = 'black';h.FontName = fn;h.FontSize = fs_labels;
%colour limits to keep consistency between figures
h.ColorLimits=[1 4];

%re-arranging y-axis energy values
h.SourceTable.Energy = categorical(h.SourceTable.Energy);
neworder = NO;
h.SourceTable.Energy = reordercats(h.SourceTable.Energy,neworder);

%removing y-axis label
h.YLabel=' ';
%removing x-axis label
h.XLabel=' ';
%axis fontname and fontsize
ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;
%figure size
fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];

%save figure to output directory with specified name and file extenstion
figureFileName = 'hm-vary-thetaB-high.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');

%% steadystate quantity heatmaps varying thetas
%import data
csvFileName = sprintf('%s\\thetaA-low-number-stable.csv', dataFilesDirectory);
T = readtable(csvFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%theta_A "low" values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%create heatmap figure
fig_heatmap = figure('Name','Heatmap','Visible','off');
%plotting heatmap from table T2' with b on the x-axis and energy values on the y-axis
h = heatmap(T,'thetaA','Energy','Title','','ColorVariable','NumberStableSteadyStates');
%colour scheme to use -- could use spring or summer or parula
h.Colormap = cool;
%data colour and label if missing
h.MissingDataColor = [0.8 0.8 0.8];h.MissingDataLabel = 'No data';
%method to use for displaying data
h.ColorMethod = 'none';
%color bar visible or not in figures
h.ColorbarVisible = 'off';
%fontname, colour and fontsize
h.FontColor = 'black';h.FontName = fn;h.FontSize = fs_labels;
%colour limits to keep consistency between figures
h.ColorLimits=[1 4];

%re-arranging y-axis energy values
h.SourceTable.Energy = categorical(h.SourceTable.Energy);
neworder = NO;
h.SourceTable.Energy = reordercats(h.SourceTable.Energy,neworder);

%removing y-axis label
h.YLabel=' ';
%removing x-axis label
h.XLabel=' ';
%axis fontname and fontsize
ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;
%figure size
fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];

%save figure to output directory with specified name and file extenstion
figureFileName = 'hm-vary-thetaA-low.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');

%% steadystate quantity heatmaps varying thetas
%import data
csvFileName = sprintf('%s\\thetaB-low-number-stable.csv', dataFilesDirectory);
T = readtable(csvFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%theta_B "low" values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%create heatmap figure
fig_heatmap = figure('Name','Heatmap','Visible','off');
%plotting heatmap from table T2' with b on the x-axis and energy values on the y-axis
h = heatmap(T,'thetaB','Energy','Title','','ColorVariable','NumberStableSteadyStates');
%colour scheme to use -- could use spring or summer or parula
h.Colormap = cool;
%data colour and label if missing
h.MissingDataColor = [0.8 0.8 0.8];h.MissingDataLabel = 'No data';
%method to use for displaying data
h.ColorMethod = 'none';
%color bar visible or not in figures
h.ColorbarVisible = 'off';
%fontname, colour and fontsize
h.FontColor = 'black';h.FontName = fn;h.FontSize = fs_labels;
%colour limits to keep consistency between figures
h.ColorLimits=[1 4];

%re-arranging y-axis energy values
h.SourceTable.Energy = categorical(h.SourceTable.Energy);
neworder = NO;
h.SourceTable.Energy = reordercats(h.SourceTable.Energy,neworder);

%removing y-axis label
h.YLabel=' ';
%removing x-axis label
h.XLabel=' ';
%axis fontname and fontsize
ax = gca;ax.FontSize=fs_axis;ax.FontName=fn;
%figure size
fig = gcf;fig.Units='centimeters';fig.Position=[0 0 wd ht];fig.PaperUnits='centimeters';fig.PaperSize=[wd ht];

%save figure to output directory with specified name and file extenstion
figureFileName = 'hm-vary-thetaB-low.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');
