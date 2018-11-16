classdef GeneticInvadersSession < handle

    properties (Access=private)
        % objects
        guiObj
        engineObj
        configurationObj
        terminate
    end

    methods
        
        function obj = GeneticInvadersSession(configurationObj)
            if nargin == 1
                configurationObj = GeneticInvadersConfiguration();
            end
            obj.configurationObj = configurationObj;
            obj.engineObj = GeneticInvadersEngine(obj);
        end
        
        function launch(obj)
            obj.createGUI();
        end
        
        function guiObj = createGUI(obj)
            guiObj = GeneticInvadersGUI(obj);
            
            obj.engineObj.setGUI(guiObj);
            
            obj.guiObj = guiObj;
            obj.guiObj.show();
        end
        
        function start(obj)
            obj.terminate = false;
            obj.engineObj.start();
            obj.run();
        end
        
        function stop(obj)
            obj.terminate = true;
        end
        
        function guiObj = getGUI(obj)
            guiObj = obj.guiObj;
        end
        
        function sessionObj = getConfiguration(obj)
            sessionObj = obj.configurationObj;
        end
        
        function run(obj, untilFcn)
            % if no "untilFcn" has been specified..
            if nargin == 1
                % run forever
                untilFcn = @true;
            end
            while (1)
                if (nargin == 2 && ~untilFcn()) || obj.terminate
                    break
                end
                duration_total = obj.tick();
            end
        end
        
        function moveShipLeft(obj)
            obj.engineObj.moveShipX(-1.49);
        end
        
        function moveShipRight(obj)
            obj.engineObj.moveShipX(1.49);
        end
        
        function fire(obj)
            obj.engineObj.fire();
        end
        
        function duration = tick(obj)
            % tick the engine
            duration = tick(obj.engineObj);
        end
        
        function exit(obj)
            obj.stop();
            drawnow;
            obj.guiObj.close();
            drawnow;
        end
                

    end % methods
    
end
