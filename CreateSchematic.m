%CREATESCHEMATIC Create town schematic 
%
% Author: M.T.Gallagher 2017, all rights reserve
% E-mail: m.t.gallagher@bham.ac.ukd
% URL:    http://www.meuriggallagher.com/
function [S,schematic] = CreateSchematic(S)

% Specify schematic size
nX = input('Please enter desired width in pixels for schematic: ');
nY = input('Please enter desired height in pixels for schematic: ');

schematic = zeros(nY,nX);
percentageImage = zeros(nY,nX);

fprintf('Constructing schematic: ')
outputCount = 1;

for jj = 1:S(1).nBuildings
    % Number of points in building
    nPoints = S(jj).X;
    nPoints(isnan(nPoints)) = [];
    nPoints = length(nPoints);
    
    % Create dummy image
    dumImg = zeros(nY,nX);
    dumPctg = dumImg;
    
    %
    x0 = zeros(nPoints-1,2);
    y0 = x0; x1 = x0; y1 = x0;
    
    % Plots all buildings
    for ii = 2:nPoints
        % Start points for boundaries
        x0(ii-1,:) = [S(jj).X(ii-1), S(jj).X(ii)];
        y0(ii-1,:) = [S(jj).Y(ii-1), S(jj).Y(ii)];
        
        % End points for corners
        if ii < nPoints
            x1(ii-1,:) = [S(jj).X(ii), S(jj).X(ii+1)];
            y1(ii-1,:) = [S(jj).Y(ii), S(jj).Y(ii+1)];
        else
            x1(ii-1,:) = [S(jj).X(ii), S(jj).X(2)];
            y1(ii-1,:) = [S(jj).Y(ii), S(jj).Y(2)];
        end
        
        % Convert points to distance measured on size of image
        x0(ii-1,:) = (x0(ii-1,:) - S(1).minX) / (S(1).maxX - S(1).minX) * (nX-1)+1;
        y0(ii-1,:) = (y0(ii-1,:) - minY) / (S(1).maxY - S(1).minY) * (nY-1)+1;
        x1(ii-1,:) = (x1(ii-1,:) - S(1).minX) / (S(1).maxX - S(1).minX) * (nX-1)+1;
        y1(ii-1,:) = (y1(ii-1,:) - S(1).minY) / (S(1).maxY - minY) * (nY-1)+1;
        
        if x0(2) ~= x0(1)
            % Write line as y = mx + c
            m(1) = (y0(ii-1,2)-y0(ii-1,1)) / (x0(ii-1,2)-x0(ii-1,1));
            c(1) = y0(ii-1,1) - m(1) * x0(ii-1,1);
            
            % Write line as y = mx + c
            m(2) = (y1(ii-1,2)-y1(ii-1,1)) / (x1(ii-1,2)-x1(ii-1,1));
            c(2) = y1(ii-1,1) - m(2) * x1(ii-1,1);
        end
        
        % Straight line distance
        dist = sqrt((y0(ii-1,2)-y0(ii-1,1))^2 + (x0(ii-1,2)-x0(ii-1,1))^2);
        
        % Create straight line
        if x0(ii-1,1) < x0(ii-1,2)
            x = linspace(x0(ii-1,1),x0(ii-1,2),2*round(dist));
        else
            x = fliplr(linspace(x0(ii-1,2),x0(ii-1,1),2*round(dist)));
        end
        if y0(1) < y0(2)
            y = linspace(y0(ii-1,1),y0(ii-1,2),2*round(dist));
        else
            y = fliplr(linspace(y0(ii-1,2),y0(ii-1,1),2*round(dist)));
        end
        
        points = [x(:),y(:)];
        
        points = floor(points);
        points = unique(points,'rows','stable');
        
        if ~isempty(points)
            % Direction vector
            directions = zeros(size(points,1),1);
            
            %% Calculate first direction
            % Specify direction
            %   4   3   2
            %   5   .   1
            %   6   7   8
            %
            if points(1,2) == points(2,2)
                % 1 or 5
                if points(1,1) < points(2,1)
                    % 1
                    directions(1) = 1;
                else
                    % 5
                    directions(1) = 5;
                end
            elseif points(2,1) == points(1,1)
                % 3 or 7
                if points(1,2) < points(2,2)
                    % 3
                    directions(1) = 3;
                else
                    % 7
                    directions(1) = 7;
                end
            elseif points(1,1) < points(2,1)
                % 2 or 8
                if points(1,2) < points(2,2)
                    % 2
                    directions(1) = 2;
                else
                    % 8
                    directions(1) = 8;
                end
            elseif points(1,2) < points(2,2)
                % 4
                directions(1) = 4;
            else
                % 6
                directions(1) = 6;
            end
            
            
            %% For each border pixel calculate percentage coverage
            coveringPercent = zeros(size(points,1),1);
            for kk = 2 : size(points,1)-1
                [coveringPercent(kk),directions(kk)] = ...
                    CalcPercentageCovering( ...
                    points(kk,:),points(kk+1,:),directions(kk-1),m(1),c(1));
                
                dumPctg(points(kk,2),points(kk,1)) = ...
                    coveringPercent(kk);
            end
            
            % Fill in corners as 100%
            dumPctg(points(1,2),points(1,1)) = 1;
            dumPctg(points(end,2),points(end,1)) = 1;
            
            %% Fill in points
            for kk = 2:size(points,1) - 1
                dumImg(points(kk,2),points(kk,1)) = 1;
            end
            
            %% Fill in corners
            dumImg(points(1,2),points(1,1)) = 1;
            dumImg(points(end,2),points(end,1)) = 1;
        end
        
        % Fill holes
        dumImg = imfill(dumImg,'holes');
        
        % Assign coverage
        ind = find(dumImg == 1);
        
        % Update dummy percentage image
        for kk = 1:length(ind)
            if dumPctg(ind(kk)) == 0
                dumPctg(ind(kk)) = 1;
            end
            
            % Update actual image if dumPctg > percentageImage
            if dumPctg(ind(kk)) > percentageImage(ind(kk))
                percentageImage(ind(kk)) = dumPctg(ind(kk));
                schematic(ind(kk)) = S(jj).buildingType;
            end
        end
    end
    
    if jj / S(1).nBuildings > outputCount/10
        fprintf(' %i%%',outputCount*10)
        outputCount = outputCount + 1;
    end
end
fprintf(' 100%%\n\n')

end