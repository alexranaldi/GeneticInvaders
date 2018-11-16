classdef GeneticInvadersAxes < handle

    properties (SetAccess=private)
        % objects
        guiObj
        sessionObj
        configurationObj      
        
        hAxes
    end
    
    methods
        function obj = GeneticInvadersAxes(guiObj)
            obj.guiObj = guiObj;
            obj.sessionObj = guiObj.getSession();
            obj.configurationObj = obj.sessionObj.getConfiguration();
            
            obj.createAxes();
        end
        

        function h = line(obj, varargin)
            h = line(obj.hAxes,varargin{:});
        end

        function onClose(obj, varargin)
            obj.close();
        end        
        
        function r = rectangle(obj, varargin)
            r = rectangle(obj.hAxes, varargin{:});
        end
        
        function h = patch(obj, varargin)
            h = patch(obj.hAxes,varargin{:});
        end
        
        function setPosition(obj, pos)
            set(obj.hAxes, 'position', pos);
        end
        
        function [xInd, yInd] = getCurrentMouseInd(obj)
            cp = get(obj.hAxes,'CurrentPoint');
            xInd = fix(cp(1,1)) + 1;
            yInd = fix(cp(1,2)) + 1;
        end
        
        function onMouseMove(obj, varargin)
            [xInd, yInd] = obj.getCurrentMouseInd();
            if isempty(obj.clickCoord)
                if xInd >= 1 && xInd <= obj.MAX_X && yInd >= 1 && yInd <= obj.MAX_Y
                    obj.setCurrentBlock(xInd, yInd);
                else
                    set(obj.hMousePointerPatch, 'Visible', 'off');
                end
            else
                % pan
            end
        end

        function onClick(obj, ~, ~, dir)
            [xInd, yInd] = getCurrentMouseInd(obj);
            ind = [xInd, yInd];
            if strcmp(dir, 'down')
                obj.clickCoord = ind;
            else
                if ~isempty(obj.clickCoord)
                    if any(obj.clickCoord ~= ind)
                        % Pan
                        currLim = obj.getViewLimits();
                        newLim = currLim;
                        dx = xInd - obj.clickCoord(1);
                        dy = yInd - obj.clickCoord(2);
                        if dx ~=0 || dy ~= 0
                            newLim(1,:) = newLim(1,:) - dx;
                            newLim(2,:) = newLim(2,:) - dy;
                            setViewLimits(obj, newLim);
                        end
                    else
                        % Execute Action
                        obj.executeAction();
                    end
                    obj.clickCoord = [];
                end
            end
        end
        
        function createAxes(obj)
            obj.hAxes = axes('parent', obj.guiObj.getFigure(), ...
                'ydir', 'Normal', ...
                'Units','pixels',...
                'xlimmode','manual',...
                'xticklabel',{''},...
                'yticklabel',{''},...
                'xtick',[],...
                'ytick',[],...
                'box','on',...
                'ylimmode','manual',...
                'xlim', [0, obj.configurationObj.maxX], ...
                'ylim', [0, obj.configurationObj.maxY], ...
                'DataAspectRatio',[1 1 1],...
                'HitTest', 'on');
        end

        function draw(obj)
            
        end
        
    end
    
end

