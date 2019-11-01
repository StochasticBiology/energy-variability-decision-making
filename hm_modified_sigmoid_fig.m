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
NO = {'1','0.9','0.8','0.7','0.6','0.5','0.4','0.3','0.2','0.1','0'};
% % NO = {'2','1.9','1.8','1.7','1.6','1.5','1.4','1.3','1.2','1.1','1','0.9','0.8','0.7','0.6','0.5','0.4','0.3','0.2','0.1','0'};
% NO = {'2','1.8','1.6','1.4','1.2','1','0.8','0.6','0.4','0.2','0'};
%% steadystate quantity heatmaps

n = 4;

% csvFileName = sprintf('%s\\number-stable-ss-shifted-sigmoid.csv',dataFilesDirectory); % shifted vertically sigmoid
% csvFileName = sprintf('%s\\number-stable-ss-increased-sigmoid.csv',dataFilesDirectory); % increased sigmoid
% csvFileName = sprintf('%s\\number-stable-ss-n4-increased-magnitude-sigmoid.csv',dataFilesDirectory); % steep sigmoid
% csvFileName = sprintf('%s\\number-stable-ss-n4-increased-energy.csv',dataFilesDirectory); % increased energy
csvFileName = sprintf('%s\\number-stable-ss-different-sigmoid-parameters.csv',dataFilesDirectory); % modified parameters

T = readtable(csvFileName);

aValue = T(:,1);
b_col = T(:,2);
k_col = T(:,3);

%set activation values to produce heatmaps for
for a=[0,0.5,1,1.5,2,3]

    FinalTable = T(T.a == a,:);

    %creating figure
    fig_heatmap = figure('Name','Heatmap','Visible','off');
    %plotting heatmap from table T2' with b on the x-axis and energy values on the y-axis
    h = heatmap(FinalTable,'b','Energy','Title','','ColorVariable','NumberStableSteadyStates');
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
%     figureFileName = sprintf('hm_n%d_shifted_sigmoid_a=%.0f.svg',n,a*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg'); % shifted vertically sigmoid
%     figureFileName = sprintf('hm_n%d_increased_sigmoid_a=%.0f.svg',n,a*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg'); % increased sigmoid
%     figureFileName = sprintf('hm_n%d_increased_magnitude_sigmoid_a=%.0f.svg',n,a*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg'); % steep sigmoid
    figureFileName = sprintf('hm_n%d_different_sigmoid_parameters_a=%.0f.svg',n,a*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg'); % modified parameters
end

