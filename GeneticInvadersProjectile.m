classdef GeneticInvadersProjectile < handle

    properties (SetAccess=private)
        % objects
        axesObj
        handles
        positionX
        positionY
        finishedFlag
    end
    
    methods
        function obj = GeneticInvadersProjectile(axesObj, configurationObj, initialPosition)
            obj.axesObj = axesObj;            
            obj.createProjectile(configurationObj, initialPosition);
        end
        
        function createProjectile(obj, configurationObj, initialPosition)
            obj.handles = [];
            
            obj.handles(1) = line(obj.axesObj, ...
                'hittest', 'off', ...
                'xdata', initialPosition(1), ...
                'ydata', initialPosition(2), ...
                'color', [0 0 0],...
                'marker', 's',...
                'linewidth',2,...
                'markersize',1,...
                'markerfacecolor', [0 0 0],...
                'markeredgecolor', [0 0 0],...
                'visible', 'on');
            
            obj.positionX = initialPosition(1);
            obj.positionY = initialPosition(2);
            
            obj.finishedFlag = false;
        end
        
        function remove(obj)
            for k = 1 : numel(obj)
                ix = ishandle(obj(k).handles);
                if any(ix)
                    delete(obj(k).handles(ix));
                end
            end
        end        
        
        function finished(obj)
            obj.finishedFlag = true;
        end        
        
        function setXPosition(obj, xpos)
            obj.positionX = xpos;
        end
        
        function setYPosition(obj, ypos)
            obj.positionY = ypos;
        end
        
        function x_position = getXPosition(obj)
            x_position = obj.positionX;
        end
        
        function y_position = getYPosition(obj)
            y_position = obj.positionY;
        end
        
        function draw(obj)
            for k = 1 : numel(obj)
                set(obj(k).handles, 'xdata', obj(k).positionX , 'ydata', obj(k).positionY);
            end
        end
    end
    
end

