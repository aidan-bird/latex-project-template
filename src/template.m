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

figure_name = "name";

% run('./utils.m');
% path_graphX = strcat(dataPath, 'XXX.csv');
% graph_data = csvread(path_graphX);

ylbl = "";
xlbl = "";
p = plot(x, y);
xlabel(xlbl);
ylabel(ylbl);
grid off;

if !interactive
    fig_path = strcat('./', figure_name);
    print('-fillpage', '-landscape', '-dpdflatex', fig_path);
end
if interactive
    disp('done building figure');
    pause;
end
