%%%code in this script is produced with comments explaining what the line of code next to or below it does
%%%code is explained for lambda([ATP]) figure

%% UNIVERSAL VALUES

%pre-setting the font, figure size and fontsizes
fn='Helvetica';fs_labels=15;fs_axis=14;wd=14;ht=12;

%energy ratio range
A_star=linspace(0,1,250);

%output directory for figure
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\figures'; % PC
% figuresDirectory =
% '\Users\rdk316\Dropbox\PhD\publications\energy_variability_decision_making\manuscript\figures\new_figs-25apr\latex\bif-diagrams\figs'; % Mac


%% SIGMOIDAL LAMBDA

%lambda([ATP])
l= @(A_star) 1./(1+exp(-(16*A_star-8)));

%creating figure
sigmoid_fig=figure('Name','Sigmoidal Function');clf;
%adding grid and box to figure
box on;hold on;grid on;
%x and y axes limits
xlim([0 1]);ylim([0 1]);
%plotting the sigmoidal curve
plot(A_star,l(A_star),'m-','LineWidth',2);
%x1-axis settings
ax1=gca;
% ax1.XLabel.String='$A^{*}$';
% ax1.XLabel.Interpreter='latex';
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
% ax1.YLabel.String='$\lambda(A^{*})$';
% ax1.YLabel.Interpreter='latex';
ax1.YTick = 0:0.1:1;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';

ax1_pos = ax1.Position;

ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
ax2.YTick=[];
ax2.XTick = 0:0.2:1;

valueOfA = zeros(1,6);

for i = 1:6
    val = ax2.XTick(i)*2760;
    valueOfA(i) = val;
end
ax2.XTickLabel = {valueOfA(1),valueOfA(2),valueOfA(3),valueOfA(4),valueOfA(5),valueOfA(6)};
ax2.TickDir = 'out';
ax2.FontSize = fs_axis;

set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'sigmoidal_function.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(sigmoid_fig,fullFileName,'-dsvg');

%% LINEAR FUNCTION

%%%code in this script is produced with comments explaining what the line of code next to or below it does
%%%code is explained for lambda([ATP]) figure

%lambda([ATP])
l= @(A_star) A_star;

%creating figure
linear_fig=figure('Name','Linear Function');clf;
%adding grid and box to figure
box on;hold on;grid on;
%x and y axes limits
xlim([0 1]);ylim([0 1]);
%plotting the sigmoidal curve
plot(A_star,l(A_star),'m-','LineWidth',2);
%x1-axis settings
ax1=gca;
% ax1.XLabel.String='$A^{*}$';
% ax1.XLabel.Interpreter='latex';
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;

% ax1.YLabel.String='$\lambda(A^{*})$';
% ax1.YLabel.Interpreter='latex';
ax1.YTick = 0:0.1:1;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';
ax1_pos = ax1.Position;

ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
ax2.YTick=[];
ax2.XTick = 0:0.2:1;
ax2.FontSize=fs_axis;

valueOfA = zeros(1,6);

for i = 1:6
    val = ax2.XTick(i)*2760;
    valueOfA(i) = val;
end
ax2.XTickLabel = {valueOfA(1),valueOfA(2),valueOfA(3),valueOfA(4),valueOfA(5),valueOfA(6)};
ax2.TickDir = 'out';

% set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'linear_function.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(linear_fig,fullFileName,'-dsvg');

%% SIGMOIDAL LAMBDA VERTICAL DISPLACEMENT

%lambda([ATP])
l= @(A_star) 1./(1+exp(-(16*A_star-8))) + 0.5;

%creating figure
sigmoid_fig_displaced=figure('Name','Sigmoidal Function Vertically Displaced');clf;
%adding grid and box to figure
box on;hold on;grid on;
%x and y axes limits
xlim([0 1]);ylim([0 2]);
%plotting the sigmoidal curve
plot(A_star,l(A_star),'m-','LineWidth',2);
%x1-axis settings
ax1=gca;
% ax1.XLabel.String='$A^{*}$';
% ax1.XLabel.Interpreter='latex';
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
% ax1.YLabel.String='$\lambda(A^{*})$';
% ax1.YLabel.Interpreter='latex';
ax1.YTick = 0:0.25:2;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';

% ax1_pos = ax1.Position;

% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');
% ax2.YTick=[];
% ax2.XTick = 0:0.2:1;

% valueOfA = zeros(1,6);
% 
% for i = 1:6
%     val = ax2.XTick(i)*2760;
%     valueOfA(i) = val;
% end
% ax2.XTickLabel = {valueOfA(1),valueOfA(2),valueOfA(3),valueOfA(4),valueOfA(5),valueOfA(6)};
% ax2.TickDir = 'out';
% ax2.FontSize = fs_axis;

set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'sigmoidal_function_shifted.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(sigmoid_fig_displaced,fullFileName,'-dsvg');

%% SIGMOIDAL LAMBDA INCREASED MAXIMUM

%lambda([ATP])
l= @(A_star) 2./(1+exp(-(16*A_star-8)));

%creating figure
sigmoid_fig_displaced=figure('Name','Sigmoidal Function Increased');clf;
%adding grid and box to figure
box on;hold on;grid on;
%x and y axes limits
xlim([0 1]);ylim([0 2]);
%plotting the sigmoidal curve
plot(A_star,l(A_star),'m-','LineWidth',2);
%x1-axis settings
ax1=gca;
% ax1.XLabel.String='$A^{*}$';
% ax1.XLabel.Interpreter='latex';
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
% ax1.YLabel.String='$\lambda(A^{*})$';
% ax1.YLabel.Interpreter='latex';
ax1.YTick = 0:0.25:2;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';

ax1_pos = ax1.Position;

% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');
% ax2.YTick=[];
% ax2.XTick = 0:0.2:1;

% valueOfA = zeros(1,6);
% 
% for i = 1:6
%     val = ax2.XTick(i)*2760;
%     valueOfA(i) = val;
% end
% ax2.XTickLabel = {valueOfA(1),valueOfA(2),valueOfA(3),valueOfA(4),valueOfA(5),valueOfA(6)};
% ax2.TickDir = 'out';
% ax2.FontSize = fs_axis;

set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'sigmoidal_function_increased.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(sigmoid_fig_displaced,fullFileName,'-dsvg');

%% ENERGY INCREASED

%lambda([ATP])
A_star=linspace(0,2,500);
l= @(A_star) 2./(1+exp(-(9*A_star-9)));

%creating figure
sigmoid_fig_energy_increased=figure('Name','Sigmoidal Function Energy Increased');clf;
%adding grid and box to figure
box on;hold on;grid on;
%x and y axes limits
xlim([0 2]);ylim([0 2]);
%plotting the sigmoidal curve
plot(A_star,l(A_star),'m-','LineWidth',2);
%x1-axis settings
ax1=gca;
% ax1.XLabel.String='$A^{*}$';
% ax1.XLabel.Interpreter='latex';
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.2:2;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
% ax1.YLabel.String='$\lambda(A^{*})$';
% ax1.YLabel.Interpreter='latex';
ax1.YTick = 0:0.25:2;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';

ax1_pos = ax1.Position;

% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');
% ax2.YTick=[];
% ax2.XTick = 0:0.2:1;

% valueOfA = zeros(1,6);
% 
% for i = 1:6
%     val = ax2.XTick(i)*2760;
%     valueOfA(i) = val;
% end
% ax2.XTickLabel = {valueOfA(1),valueOfA(2),valueOfA(3),valueOfA(4),valueOfA(5),valueOfA(6)};
% ax2.TickDir = 'out';
% ax2.FontSize = fs_axis;

set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'sigmoidal_function_energy_increased.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(sigmoid_fig_energy_increased,fullFileName,'-dsvg');

%% SIGMOID INCREASED MAGNITUDE PARAMTETERS

%lambda([ATP])
A_star=linspace(0,1,250);
l= @(A_star) 1./(1+exp(-(100*A_star-70)));

%creating figure
sigmoid_fig_energy_increased=figure('Name','Sigmoidal Function Energy Increased');clf;
%adding grid and box to figure
box on;hold on;grid on;
%x and y axes limits
xlim([0 1]);ylim([0 1]);
%plotting the sigmoidal curve
plot(A_star,l(A_star),'m-','LineWidth',2);
%x1-axis settings
ax1=gca;
% ax1.XLabel.String='$A^{*}$';
% ax1.XLabel.Interpreter='latex';
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
% ax1.YLabel.String='$\lambda(A^{*})$';
% ax1.YLabel.Interpreter='latex';
ax1.YTick = 0:0.2:2;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';

ax1_pos = ax1.Position;

% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');
% ax2.YTick=[];
% ax2.XTick = 0:0.2:1;

% valueOfA = zeros(1,6);
% 
% for i = 1:6
%     val = ax2.XTick(i)*2760;
%     valueOfA(i) = val;
% end
% ax2.XTickLabel = {valueOfA(1),valueOfA(2),valueOfA(3),valueOfA(4),valueOfA(5),valueOfA(6)};
% ax2.TickDir = 'out';
% ax2.FontSize = fs_axis;

set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'sigmoidal_function_increased_magnitude_parameters.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(sigmoid_fig_energy_increased,fullFileName,'-dsvg');

%% SIGMOID MODIFIED PARAMTETERS

%lambda([ATP])
A_star=linspace(0,1,250);
l= @(A_star) 1./(1+exp(-(4.134*A_star-3.823)));

%creating figure
sigmoid_fig_energy_increased=figure('Name','Sigmoidal Function Different Parameters');clf;
%adding grid and box to figure
box on;hold on;grid on;
%x and y axes limits
xlim([0 1]);ylim([0 1]);
%plotting the sigmoidal curve
plot(A_star,l(A_star),'m-','LineWidth',2);
%x1-axis settings
ax1=gca;
% ax1.XLabel.String='$A^{*}$';
% ax1.XLabel.Interpreter='latex';
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
% ax1.YLabel.String='$\lambda(A^{*})$';
% ax1.YLabel.Interpreter='latex';
ax1.YTick = 0:0.1:1;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';

ax1_pos = ax1.Position;

% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');
% ax2.YTick=[];
% ax2.XTick = 0:0.2:1;

% valueOfA = zeros(1,6);
% 
% for i = 1:6
%     val = ax2.XTick(i)*2760;
%     valueOfA(i) = val;
% end
% ax2.XTickLabel = {valueOfA(1),valueOfA(2),valueOfA(3),valueOfA(4),valueOfA(5),valueOfA(6)};
% ax2.TickDir = 'out';
% ax2.FontSize = fs_axis;

set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%saving produced figure to output directory with specified name and file extenstion
figureFileName = 'sigmoidal_function_modified_parameters.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(sigmoid_fig_energy_increased,fullFileName,'-dsvg');
