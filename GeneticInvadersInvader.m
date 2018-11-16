classdef GeneticInvadersInvader < handle

    properties (Constant)
        X_DIR_POS = 1
        X_DIR_NEG = -1
    end
    
    properties (SetAccess=private)
        % objects
        axesObj
        handles
        positionX
        positionY
        directionX
        
        matrix
        ind
        totalDensity
        color
        finishedFlag
        hitFlag
        configurationObj
        genePoolObj
    end
    
    methods
        function obj = GeneticInvadersInvader(axesObj, configurationObj, initialPosition, genePoolObj)
            obj.hitFlag = false;
            obj.finishedFlag = false;
            obj.color = [0 0 0];
            obj.axesObj = axesObj;            
            obj.configurationObj = configurationObj;
            obj.createInvaderFromGenes(genePoolObj);
            obj.createInvaderGraphics(initialPosition);
            if rand(1) < 0.5
                obj.directionX = GeneticInvadersInvader.X_DIR_POS;
            else
                obj.directionX = GeneticInvadersInvader.X_DIR_NEG;
            end
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
        
        function x_direction = getXDirection(obj)
            x_direction = obj.directionX;
        end
        
        function setXDirection(obj, d)
            obj.directionX = d;
        end
        
        function y_position = getYPosition(obj)
            y_position = obj.positionY;
        end
        
        function hit(obj)
            obj.hitFlag = true;
        end
        
        function finished(obj)
            obj.finishedFlag = true;
        end        
        
        function p = getGenePool(obj)
            p = obj.genePoolObj;
        end
        
        function remove(obj)
            for k = 1 : numel(obj)
                ix = ishandle(obj(k).handles);
                if any(ix)
                    delete(obj(k).handles(ix));
                end
            end
        end
        
        function draw(obj)
            len = obj(1).configurationObj.invaderLength;
            for o = 1 : length(obj)
                [r,c] = ind2sub([len, len], obj(o).ind);
                xdata = nan(len);
                ydata = nan(len);
                xdata(obj(o).ind) = c;
                ydata(obj(o).ind) = r;                
                set(obj(o).handles, ... 
                    'markerfacecolor', obj(o).color,...
                    'markeredgecolor', obj(o).color,...
                    'xdata', obj(o).positionX + xdata(:), ...
                    'ydata', obj(o).positionY + ydata(:) ...
                  );
                
            end
        end
    end
    
    methods (Access=private)

        function createInvaderFromGenes(obj, genePoolObj)
            
            rColorGeneObj = genePoolObj.getColorRedGene();
            gColorGeneObj = genePoolObj.getColorGreenGene();
            bColorGeneObj = genePoolObj.getColorBlueGene();
            luminosityGeneObj = genePoolObj.getLuminosityGene();
            
            r = rColorGeneObj.getVariedValue();
            g = gColorGeneObj.getVariedValue();
            b = bColorGeneObj.getVariedValue();
            l = luminosityGeneObj.getVariedValue();
            
            newColor = [r, g, b];
                        
            % adjust for luminosity
            newColor = newColor + (l - sum(newColor)) / 3;
            
            newColor = GeneticInvaderGeneColor.checkVector(newColor);
            obj.color = newColor;
            
            densityGeneObj = genePoolObj.getDensityGene();
            
            newDensity = densityGeneObj.getVariedValue();
            randFactor = randn(1)/10;
            newDensity = newDensity + (newDensity * randFactor);
            newDensity = fix(newDensity);
            if newDensity > GeneticInvaderGeneDensity.MAX
                newDensity = GeneticInvaderGeneDensity.MAX;
            elseif newDensity < 1
                newDensity = 1;
            end
            
            boldnessGeneObj = genePoolObj.getBoldnessGene();
            boldValue = boldnessGeneObj.getVariedValue();
            
            YspeedGeneObj = genePoolObj.getYSpeedGene();
            YspeedValue = YspeedGeneObj.getVariedValue();
            
            XspeedGeneObj = genePoolObj.getXSpeedGene();
            XspeedValue = XspeedGeneObj.getVariedValue();
            
            jitterGeneObj = genePoolObj.getJitterGene();
            jitterValue = jitterGeneObj.getVariedValue();
            
            obj.matrix = zeros(obj.configurationObj.invaderLength, obj.configurationObj.invaderLength);
            candind = randperm(obj.configurationObj.invaderLength*obj.configurationObj.invaderLength);
            candind = candind(1:newDensity);
            obj.matrix(candind) = 1;
            
            obj.totalDensity = sum(obj.matrix(:));
            obj.ind = find(obj.matrix);
            
            obj.genePoolObj = GeneticInvadersGenePool();
            obj.genePoolObj.getColorRedGene().setValue(obj.color(1));
            obj.genePoolObj.getColorGreenGene().setValue(obj.color(2));
            obj.genePoolObj.getColorBlueGene().setValue(obj.color(3));
            obj.genePoolObj.getLuminosityGene().setValue(sum(obj.color));
            obj.genePoolObj.getDensityGene().setValue(newDensity);
            obj.genePoolObj.getBoldnessGene().setValue(boldValue);
            obj.genePoolObj.getYSpeedGene().setValue(YspeedValue);
            obj.genePoolObj.getXSpeedGene().setValue(XspeedValue);
            obj.genePoolObj.getJitterGene().setValue(jitterValue);
        end

        function createInvaderGraphics(obj, initialPosition)
            obj.handles = [];
            obj.positionX = initialPosition(1);
            obj.positionY = initialPosition(2);
            
            xdata = nan(obj.configurationObj.invaderLength);
            ydata = nan(obj.configurationObj.invaderLength);
            
            [r,c] = ind2sub([obj.configurationObj.invaderLength, obj.configurationObj.invaderLength], obj.ind);
            
            xdata(obj.ind) = c;
            ydata(obj.ind) = r;
            
            boldness = obj.genePoolObj.getBoldnessGene().getValue();
            
            newHandle = line(obj.axesObj, ...
                'hittest', 'off', ...
                'xdata', initialPosition(1) + xdata(:), ...
                'ydata', initialPosition(2) + ydata(:), ...
                'marker', 'o',...
                'linestyle','none',...
                'linewidth', boldness,...
                'markersize',1,...
                'markerfacecolor', obj.color,...
                'markeredgecolor', obj.color,...
                'visible', 'on');
            
            obj.handles = [obj.handles, newHandle];
        end 
        
    end
    
end

