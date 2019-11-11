%% script compiles heatmap diagrams when varying n, a, b and A* with sigmoidal lambda for distance between attractors.

%font, fontsize and figure size
wd=8;ht=7;
fn='Helvetica';
fs_labels=10;
fs_axis=9;

%output directory for figure - modify individually
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\svg-figures'; % PC

%data files directory location - modify individually
dataFilesDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\data-files'; % PC

%order of A* values for y-axis -- see use further down
NO = {'1','0.9','0.8','0.7','0.6','0.5','0.4','0.3','0.2','0.1','0'};

%% minimum transition distance heatmaps

for n = 4%[1,2,3,4]
	
	%import data
% %     csvFileName = sprintf('%s\\sigmoid-n%.0f-min-transition-dist.csv',dataFilesDirectory,n);
    csvFileName = sprintf('%s\\sigmoid-n%.0f-extreme-basin-transition-dist-NEW.csv',dataFilesDirectory,n);
	T = readtable(csvFileName);

	%loop through a
    for a=[0,0.5,1,1.5,2,3]
		
		%sub-table for a value
        subTable = T(T.a == a,:);
	
        %create heatmap figure
        fig_heatmap = figure('Name','Heatmap','Visible','off');
        %plotting heatmap from subtable with b on the x-axis and energy
        %values on the y-axis. Variable for colouring is now distance
        %between attractors
        h = heatmap(subTable,'b','Energy','Title','','ColorVariable','MinimumTransitionDistance');
        %colour scheme to use -- could use spring or summer or parula
        h.Colormap = jet;
        %data colour and label if missing
        h.MissingDataColor = [0 0 0];%h.MissingDataLabel = 'No data';
        %method to use for displaying data
        h.ColorMethod = 'none';
        %color bar visible or not in figures
        h.ColorbarVisible = 'on';
        %fontname, colour and fontsize
        h.FontColor = 'black';h.FontName = fn;h.FontSize = fs_labels;
        %colour limits to keep consistency between figures
        h.ColorLimits=[0 9];
        
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
        figureFileName = sprintf('hm_n%d_extreme_basin_transition_min_work_a=%.0f.svg',n,a*100);fullFileName=fullfile(figuresDirectory, figureFileName);print(fig_heatmap,fullFileName,'-dsvg');
    end
end

