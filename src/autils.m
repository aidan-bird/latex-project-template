%
% Aidan Bird 2021
%
% autils.m
%
% Various functions that do useful things.
%
pkg load optim;

function ix = findIndexByValue(vec, x)
    [~, ix] = min(((ones(rows(vec), 1) * x) - vec).^2);
endfunction;

% fit a line to a data set by selecting a region begining at xStart and ending
% at xEnd, where xStart and xEnd are the x-values from the data set.
function params = fitlineByX(xy, xStart, xEnd)
    % find region
    iStart = findIndexByValue(xy(:, 1), xStart);
    iEnd = findIndexByValue(xy(:, 1), xEnd);
    params = fitlineByIndex(xy, iStart, iEnd);
endfunction;

% fit a line to a data set by selecting a region begining at iStart and ending
% at iEnd, where iStart and iEnd are the indexes of rows in the data set.
function params = fitlineByIndex(xy, iStart, iEnd)
    % linear regression
    subset_xy = xy(iStart:iEnd,:);
    F = [ones(rows(subset_xy), 1), subset_xy(:,1)];
    [p, ~, ~, p_var, fit_var] = LinearRegression(F, subset_xy(:,2));
    params = p;
endfunction;

% Find a linear region in a curve. maxError is a value that ranges from 0 to 1.
function iEnd = findLinearRegionByIndex(xy, iStart, sampleSize, maxError)
    lmParams = fitlineByIndex(xy, iStart, iStart + sampleSize - 1);
    xySubset = xy(iStart:end, :);
    yfit = [ones(rows(xySubset), 1), xySubset(:, 1)] * lmParams;
    yError = abs(xySubset(:, 2) - yfit) ./ abs(xySubset(:, 2));
    yError(1) = 0;
    for i = 1:length(yError)
        if yError(i) > maxError
            iEnd = iStart + i - 1;
            return;
        endif;
    endfor;
    iEnd = rows(xy);
endfunction;

function I = findStartOfSlope(xy, iStart, direction, sampleSize, maxError)
    iEnd = 0;
    domain = 0;
    dir = 0;
    iStart2 = iStart;
    if strcmp(direction, "up")
        iEnd = iStart + sampleSize;
        domain = iStart:rows(xy);
        dir = 1;
    elseif strcmp(direction, "down")
        domain = iStart:-1:1;
        iEnd = iStart;
        iStart = iStart - sampleSize;
        dir = -1;
    else
        I = 0;
        return;
    endif;
    subsetxy = xy(domain, :);
    lmParams = fitlineByIndex(xy, iStart, iEnd);
    yfit = [ones(length(domain), 1) subsetxy(:, 1)] * lmParams;
    yError = abs(subsetxy(:, 2) - yfit) ./ abs(subsetxy(:, 2));
    yError(domain(1)) = 0;
    for i = 1:rows(yError)
        if yError(i) > maxError
            I = iStart2 + i * dir;
            return;
        endif;
    endfor;
    I = domain(end);
endfunction;


