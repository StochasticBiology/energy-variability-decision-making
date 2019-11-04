%% script compiles each form of lambda used in the manuscript.

%font, fontsize and figure size
fn='Helvetica';
fs_labels=15;fs_axis=14;
wd=14;ht=12;

%A* range
A_star=linspace(0,1,250);

%output directory for figure - modify individually
figuresDirectory = 'U:\PhD\energy_decisions_manuscript\updated-files\plot-figures\svg-figures'; % PC
%% ORIGIAL SIGMOIDAL LAMBDA

%lambda
l= @(A_star) 1./(1+exp(-(16*A_star-8)));

%create figure
sigmoid_fig=figure('Name','Sigmoidal Function');clf;
box on;hold on;grid on;
xlim([0 1]);ylim([0 1]);
plot(A_star,l(A_star),'m-','LineWidth',2);%plotting the sigmoidal curve
ax1=gca;
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
ax1.YTick = 0:0.1:1;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';
ax1_pos = ax1.Position;

%secondary x-axis
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

%save figure to output directory with specified name and file extenstion
figureFileName = 'sigmoidal_function.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(sigmoid_fig,fullFileName,'-dsvg');

%% LINEAR LAMBDA

%lambda
l= @(A_star) A_star;

%create figure
linear_fig=figure('Name','Linear Function');clf;
box on;hold on;grid on;
xlim([0 1]);ylim([0 1]);
plot(A_star,l(A_star),'m-','LineWidth',2);%plotting the sigmoidal curve
ax1=gca;
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
ax1.YTick = 0:0.1:1;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';
ax1_pos = ax1.Position;

%secondary x-axis
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

set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%save figure to output directory with specified name and file extenstion
figureFileName = 'linear_function.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(linear_fig,fullFileName,'-dsvg');

%% SIGMOIDAL LAMBDA WITH VERTICAL DISPLACEMENT

%lambda
l= @(A_star) 1./(1+exp(-(16*A_star-8))) + 0.5;

%create figure
sigmoid_fig_displaced=figure('Name','Sigmoidal Function Vertically Displaced');clf;
box on;hold on;grid on;
xlim([0 1]);ylim([0 2]);
plot(A_star,l(A_star),'m-','LineWidth',2);%plotting the sigmoidal curve
ax1=gca;
ax1.XLabel.FontSize = fs_labels;
ax1.XTick = 0:0.1:1;
ax1.XLabel.FontSize = fs_axis;
ax1.XLabel.FontName = fn;
ax1.YTick = 0:0.25:2;
ax1.YLabel.FontSize = fs_axis;
ax1.YLabel.FontName = fn;
ax1.FontSize = fs_labels;
ax1.TickDir = 'out';
set(gcf,'Units','centimeters','Position',[0 0 wd ht],'PaperUnits','centimeters','PaperSize',[wd ht]);
hold off;

%save figure to output directory with specified name and file extenstion
figureFileName = 'sigmoidal_function_shifted.svg';fullFileName=fullfile(figuresDirectory, figureFileName);print(sigmoid_fig_displaced,fullFileName,'-dsvg');
