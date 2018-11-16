classdef GeneticInvaderGeneXSpeed < GeneticInvaderGene & handle

    properties (Constant)
        % seed speed is 2 pixels/sec
        SEED = 2
    end

    methods
        function obj = GeneticInvaderGeneXSpeed()
            obj = obj@GeneticInvaderGene();
            obj.setValue(GeneticInvaderGeneXSpeed.SEED);
        end
        function setValue(obj, v)
            obj.value = obj.checkValue(v);
        end
        function v = getVariedValue(obj)
            randFactor = randn(1)/10 * 4;
            v = obj.value + (obj.value * randFactor);
            v = obj.checkValue(v);
        end        
    end
    
    methods (Access=private)
        function v = checkValue(~, v)
            % enforce speed values >= 0 and <= 20
            if v <= 0
                v = 0;
            elseif v > 20
                v = 20;
            end 
        end
    end
    
end
