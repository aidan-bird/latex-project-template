%
% Aidan Bird 2021
%
% template.m: used for making figures
%

%interactive = true;
interactive = false;

if !interactive
    figure ("visible", "off");
else
    figure ("visible", "on");
end

% setup environment
docRoot = '/XXX';
figurePath = strcat(docRoot, 'figures/');
srcPath = strcat(docRoot, 'src/');
dataPath = strcat(docRoot, 'data/');
figure_name = "template";

% include utilities
run(strcat(srcPath, 'autils.m'));

% include data
path_graphX = strcat(dataPath, 'XXX.csv');
graph_data = csvread(path_graphX);

% transform data

% make plot
ylbl = "";
xlbl = "";
p = plot(x, y);
xlabel(xlbl);
ylabel(ylbl);
grid off;

% save figure
if !interactive
    fig_path = strcat(figurePath, figure_name);
    print('-fillpage', '-landscape', '-dpdflatex', fig_path);
end
if interactive
    disp('done building figure');
    pause;
end
