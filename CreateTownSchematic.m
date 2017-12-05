%CREATETOWNSCHEMATIC Create town schematic from GIS data
%   TOWNSCHEMATIC is designed to create an indexed array schematic 
%   representing a town with different building types. 
%   
%   Data is loaded from a GIS shapefile, and takes user input to determine 
%   the type of each building present. For example, in the case of fire 
%   safety modelling, the building type could represent different 
%   construction materials.
%
%   This data is then converted to an indexed array of user specified size 
%   by asigning a pixel to each value based on the percentage coverage of 
%   each building type.
%
% Author: M.T.Gallagher 2017, all rights reserve
% E-mail: m.t.gallagher@bham.ac.ukd
% URL:    http://www.meuriggallagher.com/
function CreateTownSchematic

fprintf('---------------------------------------\n')
fprintf('---------------------------------------\n')
fprintf('CREATETOWNSCHEMATIC\n')
fprintf('\n\n')
fprintf('M.T.Gallagher 2017, all rights reserved\n')
fprintf('E-mail: m.t.gallagher@bham.ac.uk\n')
fprintf('---------------------------------------\n')
fprintf('---------------------------------------\n')
fprintf('\n\n')

fileName = input(['Please enter the name of the shapefile you' ...
    ' wish to convert: ']);


% Load data from file
S = shaperead(fileName);

% Number of buildings
S(1).nBuildings = size(S,1);

fprintf('%i buildings found in shapefile\n',S(1).nBuildings)

% Building type
S = EstablishBuildingType(S);

% Calculate schematic
[S,schematic] = CreateSchematic(S); %#ok<ASGLU>

% Save schamtic
fprintf('Saving ... ')
save('townSchematic.mat','S','schematic','-v7.3')
fprintf(' done\n\n')

fprintf('---------------------------------------\n')
fprintf('---------------------------------------\n')

end