%ESTABLISHBUILDINGTYPE Establish class of buildings in schematic
%
% Author: M.T.Gallagher 2017, all rights reserve
% E-mail: m.t.gallagher@bham.ac.ukd
% URL:    http://www.meuriggallagher.com/
function S = EstablishBuildingType(S)

figure(1)
subplot(1,2,1)
% Plot all buildings and calculate limits
S(1).minX = inf;
S(1).minY = inf;
S(1).maxX = -inf;
S(1).maxY = -inf;
for jj = 1:nBuildings
    % Number of points in building
    nPoints = length(S(jj).X);

    % Plots all buildings
    for ii = 2:nPoints
        plot([S(jj).X(ii-1),S(jj).X(ii)],[S(jj).Y(ii-1),S(jj).Y(ii)],...
            'k')
    end

    S(1).minX = min([S(1).minX, min(S(jj).X)]);
    S(1).minY = min([S(1).minY, min(S(jj).Y)]);
    S(1).maxX = max([S(1).maxX, max(S(jj).X)]);
    S(1).maxY = max([S(1).maxY, max(S(jj).Y)]);

end

% Calculate building type
fprintf('Please enter the building type identifier for each building\n')
fprintf(['If you hit return without entering anything,' ... 
    ' the identifier will be set to 0\n\n'])

for jj = 1:S(1).nBuildings

    % Plot building red
    nPoints = length(S(jj).X);
    for ii = 2:nPoints
        x0 = [S(jj).X(ii-1), S(jj).X(ii)];
        y0 = [S(jj).Y(ii-1), S(jj).Y(ii)];

        % Convert points to distance measured on size of image
        x0 = (x0 - minX) / (maxX - minX) * (nX-1)+1;
        y0 = (y0 - minY) / (maxY - minY) * (nY-1)+1;
        y0 = nY - y0;

        plot(x0,y0,'r')
    end

    S(jj).buildingType = input('Please input building type no. %i: ',jj);
    if isempty(S(jj).buildingType)
        S(jj).buildingType = 1;
    end

    subplot(1,2,1)
    imshow(dumPlan,[])
    hold on
end

end