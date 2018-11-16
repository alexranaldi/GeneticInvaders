classdef GeneticInvadersShip < handle

    properties (SetAccess=private)
        % objects
        axesObj
        handles
        position
        
        shipWidth = 10
        
        % position of the center of the ship
        y_position = 1
        x_position = 1
        
        baseCoordX = [0 0 0 0]
        baseCoordY = [0 0 0 0]
    end
    
    methods
        function obj = GeneticInvadersShip(axesObj, configurationObj)
            obj.axesObj = axesObj;            
            obj.createShip(configurationObj);
        end
        
        function createShip(obj, configurationObj)
            obj.handles = [];
            
            h = configurationObj.shipHeight;
            w = configurationObj.shipWidth;
            
            obj.shipWidth = w;
            
            obj.baseCoordX = [0 0 w w];
            obj.baseCoordY = [0 h h 0];
            
            obj.handles(1) = patch(obj.axesObj, ...
                'hittest', 'off', ...
                'xdata', obj.baseCoordX, ...
                'ydata', obj.baseCoordY, ...
                'facecolor', [0 0 0],...
                'visible', 'on');
            
        end
        
        function setXPosition(obj, xpos)
            obj.x_position = xpos;
        end
        
        function setYPosition(obj, ypos)
            obj.y_position = ypos;
        end
        
        function x_position = getXPosition(obj)
            x_position = obj.x_position;
        end
        
        function y_position = getYPosition(obj)
            y_position = obj.y_position;
        end
        
        function draw(obj)
            set(obj.handles, 'xdata', obj.baseCoordX + obj.x_position - obj.shipWidth / 2);
            set(obj.handles, 'ydata', obj.baseCoordY + obj.y_position);
        end
    end
    
end

