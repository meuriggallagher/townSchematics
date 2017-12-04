%CALCPERCENTAGECOVERING Calculate pixel percentage coverage
%
% Author: M.T.Gallagher 2017, all rights reserve
% E-mail: m.t.gallagher@bham.ac.ukd
% URL:    http://www.meuriggallagher.com/
function [coveringPercent,newDirection] = CalcPercentageCovering( ...
    oldPoint,newPoint,oldDirection,m,c)


% Specify direction
%   4   3   2
%   5   .   1
%   6   7   8
%
if oldPoint(2) == newPoint(2)
    % 1 or 5
    if oldPoint(1) < newPoint(1)
        % 1
        newDirection = 1;
        
        % Base algorithm on previous direction
        if oldDirection == 7 || oldDirection == 8
            % .     or   .
            % . .          . .
            % entry point
            startP = [(ceil(oldPoint(2))-c)/m,...
                ceil(oldPoint(2))];
            % exit point
            exitP = [ceil(oldPoint(1)), ...
                ceil(oldPoint(1))*m + c];
            
            % Area
            coveringPercent = 1 - 0.5 ...
                * (exitP(1)-startP(1))* (startP(2) - exitP(2));
            
        elseif oldDirection == 1
            % . . .
            % entry point
            startP = [floor(oldPoint(1)), ...
                floor(oldPoint(1)) * m + c];
            % exit point
            exitP = [ceil(oldPoint(1)), ...
                ceil(oldPoint(1)) * m + c];
            
            % Area
            coveringPercent = 1 - 0.5 ...
                * (exitP(1)-startP(1)) * ...
                abs(startP(2) - exitP(2)) ...
                - min([(ceil(startP(2)) - startP(2)), ...
                (ceil(startP(2)) - exitP(2))]);
            
        elseif oldDirection == 3 || oldDirection == 2
            % . .  or    . .
            % .        .
            % entry point
            startP = [(floor(oldPoint(2))-c)/m,...
                floor(oldPoint(2))];
            % exit point
            exitP = [ceil(oldPoint(1)), ...
                ceil(oldPoint(1))*m + c];
            
            % Area
            coveringPercent = 0.5 ...
                * (exitP(1)-startP(1))* (-startP(2)+exitP(2));
            
        end
    else
        % 5
        newDirection = 5;
        if oldDirection == 6 || oldDirection == 7
            %   .  or      .
            % . .      . .
            % entry point
            startP = [(ceil(oldPoint(2))-c)/m,...
                ceil(oldPoint(2))];
            % exit point
            exitP = [floor(oldPoint(1)), ...
                floor(oldPoint(1)) * m + c];
            
            % Area
            coveringPercent = 1 - 0.5 ...
                * (-exitP(1)+startP(1))*(startP(2) - exitP(2));
            
        elseif oldDirection == 5
            % . . .
            % entry point
            startP = [ceil(oldPoint(1)), ...
                ceil(oldPoint(1)) * m + c];
            % exit point
            exitP = [floor(oldPoint(1)), ...
                floor(oldPoint(1)) * m + c];
            
            % Area
            coveringPercent = 1 - 0.5 ...
                * (-exitP(1)+startP(1)) * ...
                abs(startP(2) - exitP(2)) ...
                - min([(ceil(startP(2)) - startP(2)), ...
                (ceil(startP(2)) - exitP(2))]);
            
        elseif oldDirection == 3 || oldDirection == 4
            % . .  or  . .
            %   .          .
            % entry point
            startP = [(floor(oldPoint(2))-c)/m,...
                floor(oldPoint(2))];
            % exit point
            exitP = [floor(oldPoint(1)), ...
                floor(oldPoint(1))*m +c];
            
            % Area
            coveringPercent = 0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
        end
    end
elseif oldPoint(1) == newPoint(1)
    % 3 or 7
    if oldPoint(2) < newPoint(2)
        % 3
        newDirection = 3;
        if oldDirection == 1 || oldDirection == 2
            %   .  or   .
            % . .       .
            %         .
            % entry point
            startP = [floor(oldPoint(1)), ...
                floor(oldPoint(1)) * m + c];
            % exit point
            exitP = [(ceil(oldPoint(2))-c)/m,...
                ceil(oldPoint(2))];
            
            % Area
            coveringPercent = 1 - 0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
            
        elseif oldDirection == 3
            % .
            % .
            % .
            % start point
            startP = [(floor(oldPoint(2))-c)/m,...
                floor(oldPoint(2))];
            % exit point
            exitP = [(ceil(oldPoint(2))-c)/m,...
                ceil(oldPoint(2))];
            
            % Area
            coveringPercent = 0.5 ...
                * abs(exitP(1)-startP(1)) ...
                * abs(exitP(2)-startP(2)) ...
                + (exitP(1) - floor(exitP(1)));
            
            if exitP(1) > startP(1)
                coveringPercent = 1 ...
                    - coveringPercent;
            end
            
        elseif oldDirection == 4 || oldDirection == 5
            % .  or  .
            % . .    .
            %          .
            % entry point
            startP = [ceil(oldPoint(1)), ...
                ceil(oldPoint(1)) * m + c];
            % exit point
            exitP = [(ceil(oldPoint(2))-c)/m,...
                ceil(oldPoint(2))];
            
            % Area
            coveringPercent = 1 - 0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
        end
        
    else
        % 7
        newDirection = 7;
        
        if oldDirection == 1 || oldDirection == 8
            %     or  .
            % . .       .
            %   .       .
            % entry point
            startP = [floor(oldPoint(1)), ...
                floor(oldPoint(1)) * m + c];
            % exit point
            exitP = [(floor(oldPoint(2))-c)/m,...
                floor(oldPoint(2))];
            
            % Area
            coveringPercent = 0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
            
        elseif oldDirection == 7
            % .
            % .
            % .
            % start point
            startP = [(ceil(oldPoint(2))-c)/m,...
                ceil(oldPoint(2))];
            % exit point
            exitP = [(floor(oldPoint(2))-c)/m,...
                floor(oldPoint(2))];
            
            % Area
            coveringPercent = 0.5 ...
                * abs(exitP(1)-startP(1)) ...
                * abs(exitP(2)-startP(2)) ...
                + (exitP(1) - floor(exitP(1)));
            
            if exitP(1) < startP(1)
                coveringPercent = 1 ...
                    - coveringPercent;
            end
            
        elseif oldDirection == 5 || oldDirection == 6
            %     or    .
            % . .     .
            % .       .
            % entry point
            startP = [ceil(oldPoint(1)), ...
                ceil(oldPoint(1)) * m + c];
            % exit point
            exitP = [(floor(oldPoint(2))-c)/m,...
                floor(oldPoint(2))];
            
            % Area
            coveringPercent = 0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
        end
    end
elseif oldPoint(1) < newPoint(1)
    % 2 or 8
    if oldPoint(2) < newPoint(2)
        % 2
        newDirection = 2;
        
        if oldDirection == 1 || oldDirection == 2
            %     . or     .
            % . .        .
            %          .
            % entry point
            startP = [floor(oldPoint(1)), ...
                floor(oldPoint(1)) * m + c];
            % exit point
            exitP = ceil(oldPoint);
            
            % Area
            coveringPercent = 1 - 0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
            
        elseif oldDirection == 3
            %   .
            % .
            % .
            % start point
            startP = [(floor(oldPoint(2))-c)/m,...
                floor(oldPoint(2))];
            % exit point
            exitP = ceil(oldPoint);
            
            % Area
            coveringPercent = 0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
        end
        
    else
        % 8
        newDirection = 8;
        
        if oldDirection == 1 || oldDirection == 8
            %       or .
            % . .        .
            %     .        .
            % entry point
            startP = [floor(oldPoint(1)), ...
                floor(oldPoint(1)) * m + c];
            % exit point
            exitP = [ceil(oldPoint(1)),floor(oldPoint(2))];
            
            % Area
            coveringPercent = 0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
            
        elseif oldDirection == 7
            % .
            % .
            %   .
            % entry point
            startP = [(ceil(oldPoint(2))-c)/m,...
                ceil(oldPoint(2))];
            % exit point
            exitP = [ceil(oldPoint(1)),floor(oldPoint(2))];
            
            % Area
            coveringPercent = 1-0.5 * ...
                abs(startP(1) - exitP(1)) * ...
                abs(startP(2) - exitP(2));
        end
    end
elseif oldPoint(2) < newPoint(2)
    % 4
    newDirection = 4;
    
    if oldDirection == 4 || oldDirection == 5
        % .      or .
        %   .         . .
        %     .
        % entry point
        startP = [ceil(oldPoint(1)), ...
            ceil(oldPoint(1)) * m + c];
        % exit point
        exitP = [floor(oldPoint(1)),ceil(oldPoint(2))];
        
        % Area
        coveringPercent = 1-0.5 * ...
            abs(startP(1) - exitP(1)) * ...
            abs(startP(2) - exitP(2));
        
    elseif oldDirection == 3
        % .
        %   .
        %   .
        % entry point
        startP = [(floor(oldPoint(2))-c)/m,...
            floor(oldPoint(2))];
        % exit point
        exitP = [floor(oldPoint(1)),ceil(oldPoint(2))];
        
        % Area
        coveringPercent = 0.5 * ...
            abs(startP(1) - exitP(1)) * ...
            abs(startP(2) - exitP(2));
    end
    
else
    % 6
    newDirection = 6;
    
    if oldDirection == 6 || oldDirection == 7
        %     .  or   .
        %   .         .
        % .         .
        % entry point
        startP = [(ceil(oldPoint(2))-c)/m, ...
            ceil(oldPoint(2))];
        % exit point
        exitP = floor(oldPoint);
        
        % Area
        coveringPercent = 1 - 0.5 * ...
            abs(startP(1) - exitP(1)) * ...
            abs(startP(2) - exitP(2));
        
    elseif oldDirection == 5
        %   . .
        % .
        %
        % entry point
        startP = [ceil(oldPoint(1)), ...
            ceil(oldPoint(1)) * m + c];
        % exit point
        exitP = floor(oldPoint);
        
        % Area
        coveringPercent = 1 - 0.5 * ...
            abs(startP(1) - exitP(1)) * ...
            abs(startP(2) - exitP(2));
    end
end
end