classdef GeneticInvadersGUI < handle

    properties
        % objects
        axesObj
        sessionObj
        
        % graphics handles
        hFigure
        hAxes
        hScore
    end
    
    
    methods
        
        function obj = GeneticInvadersGUI(sessionObj)
            obj.sessionObj = sessionObj;
            obj.createFigure();
            obj.axesObj = GeneticInvadersAxes(obj);
        end
        
        function show(obj)
            set(obj.hFigure, 'Visible', 'on');
        end
        
        function hide(obj)
            set(obj.hFigure, 'Visible', 'off');
        end        
        
        function draw(obj)
            obj.axesObj.draw();
            drawnow limitrate;
        end

        function shipObj = start(obj)
            shipObj = obj.axesObj.createShip(obj);
        end
        
        function axesObj = getAxes(obj)
            axesObj = obj.axesObj;
        end
        
        function sessionObj = getSession(obj)
            sessionObj = obj.sessionObj;
        end
        
        function h = getFigure(obj)
            h = obj.hFigure;
        end
        
        function setScore(obj, score)
            set(obj.hScore,'String',sprintf('Score: %d', fix(score+0.5)));
        end

        function createFigure(obj)
            obj.hFigure = figure( ...
                'Color', 'white', ...
                'DoubleBuffer','on',...
                'Name', 'GeneticInvaders', ...
                'NumberTitle', 'off', ...
                'Menubar', 'none', ...
                'Toolbar', 'none', ...
                'KeyPressFcn', @obj.onKeyPress,...
                'CloseRequestFcn',@obj.onClose,...
                'Units','pixels',...
                'Position',[100,100,400,768],...
                'Visible', 'off' ...
                );
            obj.hScore = uicontrol(...
                'style','text',...
                'parent',obj.hFigure,...
                'string','Score: 0',...
                'units','pixels',...
                'position',[40 720 100 20]);
        end
        
        function onKeyPress(obj, ~, eventData)
            key = eventData.Key;
            switch lower(key)
                case 'rightarrow'
                    obj.sessionObj.moveShipRight();
                case 'leftarrow'
                    obj.sessionObj.moveShipLeft();
                case 'space'
                    obj.sessionObj.fire();
                otherwise
            end
        end
                
        function onClose(obj, varargin)
            obj.sessionObj.exit();
        end            
        
        function close(obj)
            delete(obj.hFigure);
        end
        
    end

end
