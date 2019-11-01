%%%code in this script is produced with comments explaining what the line of code next to or below it does
%%%code is explained for all heatmap figures

%universal values
wd=8;ht=7;
fn='Helvetica';
fs_labels=10;
fs_axis=9;

%output directory for figure
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\figures'; % PC
% figuresDirectory =
% '\Users\rdk316\Dropbox\PhD\publications\energy_variability_decision_making\manuscript\figures\new_figs-25apr\latex\bif-diagrams\figs'; % Mac

%data files directory location
dataFilesDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\data-files'; % PC

%order of energy concetrations for y-axis -- see use further down
NO = {'1','0.9','0.8','0.7','0.6','0.5','0.4','0.3','0.2','0.1','0'};%{'1','0.9','0.8'};%

%% steadystate quantity heatmaps varying thetas
csvFileName = sprintf('%s\\number-stable-ss-thetaA-high.csv', dataFilesDirectory);
T = readtable(csvFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%theta_a "high" values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%creating figure
fig_heatmap = figure('Name','Heatmap');
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

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'hm-vary-thetaA-high.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');
    
%% steadystate quantity heatmaps varying thetas
csvFileName = sprintf('%s\\number-stable-ss-thetaB-high.csv', dataFilesDirectory);
T = readtable(csvFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%theta_b "high" values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%creating figure
fig_heatmap = figure('Name','Heatmap');
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

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'hm-vary-thetaB-high.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');

%% steadystate quantity heatmaps varying thetas
csvFileName = sprintf('%s\\number-stable-ss-thetaA-low.csv', dataFilesDirectory);
T = readtable(csvFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%theta_a "low" values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%creating figure
fig_heatmap = figure('Name','Heatmap');
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

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'hm-vary-thetaA-low.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');

%% steadystate quantity heatmaps varying thetas
csvFileName = sprintf('%s\\number-stable-ss-thetaB-low.csv', dataFilesDirectory);
T = readtable(csvFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%theta_b "low" values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%creating figure
fig_heatmap = figure('Name','Heatmap');
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

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'hm-vary-thetaB-low.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');
