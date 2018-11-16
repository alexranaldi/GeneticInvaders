classdef GeneticInvadersEngine < handle

    properties (Access=private)
        % objects
        configurationObj
        guiObj
        axesObj
        shipObj
        projectileObjs
        invaderObjs
        genePoolObj
        
        % numbers
        prevTime 
        duration
        time
        count
        newInvaderProbability
        startTime
        score
    end
    
    methods
        function obj = GeneticInvadersEngine(sessionObj)
            obj.count = 0;
            obj.time = 0;
            obj.newInvaderProbability = 0.20;
            obj.configurationObj = sessionObj.getConfiguration();
            obj.genePoolObj = GeneticInvadersGenePool();
        end

        function setGUI(obj, guiObj)
            obj.guiObj = guiObj;
            obj.axesObj = obj.guiObj.getAxes();
        end
        
        function tick_duration = tick(obj)
            % Main engine function - handles movement and drawing
            
            durStart = tic;
            
            obj.time = clock();
            obj.duration = etime(obj.time, obj.prevTime);
            
            obj.count = obj.count + 1;
         
            obj.moveProjectiles();
            if ~isempty(obj.projectileObjs)
                ixFinished = [obj.projectileObjs.finishedFlag];
                if any(ixFinished)
                    remove(obj.projectileObjs(ixFinished));
                    obj.projectileObjs(ixFinished) = [];                
                end        
            end
            
            if ~isempty(obj.invaderObjs)
                ixHit = [obj.invaderObjs.hitFlag];
                if any(ixHit)
                    remove(obj.invaderObjs(ixHit));
                    obj.invaderObjs(ixHit) = [];                
                end
                ixFinished = [obj.invaderObjs.finishedFlag];
                if any(ixFinished)
                    remove(obj.invaderObjs(ixFinished));
                    obj.invaderObjs(ixFinished) = [];                
                end                
            end
            
            obj.moveInvaders();
            
            obj.penetrationDetect();
            obj.collisionDetect();
         
            if ~isempty(obj.projectileObjs) && mod(obj.count, 2) == 0
                obj.projectileObjs.draw();
            end
            
            obj.makeNewInvaders();
            
            obj.shipObj.draw();
            
            if ~isempty(obj.invaderObjs) && mod(obj.count, 5) == 0
                obj.invaderObjs.draw();
            end
            
            obj.guiObj.setScore(obj.score);
            
            drawnow;
           
            tick_duration = toc(durStart);
        
            obj.prevTime = obj.time;
        
        end

        function t = getTime(obj)
            t = obj.time;
        end

        function collisionDetect(obj)
         
            if isempty(obj.projectileObjs) || isempty(obj.invaderObjs)
                return
            end
            len = obj.configurationObj.invaderLength;
            px = [obj.projectileObjs.positionX];
            py = [obj.projectileObjs. positionY];
            
            inx = [obj.invaderObjs.positionX]+3;
            iny = [obj.invaderObjs.positionY]+len;
                
            half_len = len;
             for k = 1 : numel(inx)
                tf = px >= inx(k)-half_len & px <= inx(k)+half_len & py >= iny(k)-half_len & py <= iny(k)+half_len;
                if any(tf)
                    ixlin = find(tf,1,'last');
                    obj.projectileObjs(ixlin).finished();
                    obj.invaderObjs(k).hit();
                    obj.newInvaderProbability = obj.newInvaderProbability + 0.0025;
                    obj.score = obj.score + 1 + (etime(obj.time, obj.startTime)/20);
                end
                
            end

        end
        
        function penetrationDetect(obj)
            if isempty(obj.invaderObjs)
                return
            end
            iny = [obj.invaderObjs.positionY];        
            tf = iny <= 0;
            if any(tf)
                ind = find(tf);
                for k = 1 : numel(ind)
                    invaderObj = obj.invaderObjs(ind(k));
                    obj.genePoolObj.mix(invaderObj.getGenePool());
                    obj.genePoolObj.print();
                    invaderObj(k).finished();
                end
            end
        end
        
        function start(obj)
            % create the user-controllable ship
            obj.startTime = clock();
            obj.score = 0;
            obj.shipObj = GeneticInvadersShip(obj.axesObj, obj.configurationObj);
            obj.shipObj.setXPosition(obj.configurationObj.maxX / 2);
            obj.shipObj.setYPosition(obj.configurationObj.shipY);
            obj.prevTime = clock();
        end
        
        function moveShipX(obj, amount)
            amountAdj = amount * obj.duration * 100;
            obj.shipObj.setXPosition( amountAdj + obj.shipObj.getXPosition() );
        end
        
        function moveProjectiles(obj)
            for k = 1 : numel(obj.projectileObjs)
                newY = obj.projectileObjs(k).getYPosition() + obj.duration * 40;
                if newY >= 251
                    obj.projectileObjs(k).finished();
                end
                obj.projectileObjs(k).setYPosition( newY );
            end
        end
        
        function moveInvaders(obj)
            for k = 1 : numel(obj.invaderObjs)
                if rand(1) < obj.duration * obj.invaderObjs(k).genePoolObj.getJitterGene().getValue()
                   if obj.invaderObjs(k).getXDirection() == GeneticInvadersInvader.X_DIR_POS
                       obj.invaderObjs(k).setXDirection(GeneticInvadersInvader.X_DIR_NEG);
                   else
                       obj.invaderObjs(k).setXDirection(GeneticInvadersInvader.X_DIR_POS);
                   end
                end
                oldX = obj.invaderObjs(k).getXPosition();
                newX = oldX + obj.duration * obj.invaderObjs(k).genePoolObj.getXSpeedGene().getValue() * obj.invaderObjs(k).getXDirection();
                if newX <= 3 && obj.invaderObjs(k).getXDirection() == GeneticInvadersInvader.X_DIR_NEG
                    obj.invaderObjs(k).setXDirection(GeneticInvadersInvader.X_DIR_POS);
                elseif newX >= obj.configurationObj.maxX - obj.configurationObj.invaderLength && obj.invaderObjs(k).getXDirection() == GeneticInvadersInvader.X_DIR_POS
                    obj.invaderObjs(k).setXDirection(GeneticInvadersInvader.X_DIR_NEG);
                end
                obj.invaderObjs(k).setXPosition( newX );           
                
                newY = obj.invaderObjs(k).getYPosition() - obj.duration * obj.invaderObjs(k).genePoolObj.getYSpeedGene().getValue();
                obj.invaderObjs(k).setYPosition( newY );
            end
        end        
        
        function makeNewInvaders(obj)
            if rand(1) < obj.newInvaderProbability * obj.duration
                % make new invader
                initialPosition = zeros(1,2);
                initialPosition(1) = randi(120-7);
                initialPosition(2) = 240;
                newInvaderObj = GeneticInvadersInvader(obj.axesObj, obj.configurationObj, initialPosition, obj.genePoolObj);
                obj.invaderObjs = [obj.invaderObjs, newInvaderObj];
                
            end
        end
        
        function fire(obj)
            initialPosition = zeros(1,2);
            initialPosition(1) = obj.shipObj.getXPosition();
            initialPosition(2) = obj.shipObj.getYPosition();
            newProjectileObj = GeneticInvadersProjectile(obj.axesObj, obj.configurationObj, initialPosition);
            obj.projectileObjs = [obj.projectileObjs, newProjectileObj];
        end
        
    end % methods
    
end
