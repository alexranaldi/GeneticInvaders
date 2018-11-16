classdef GeneticInvaderGeneLuminosity < GeneticInvaderGene & handle

    properties (Constant)
        SEED = 0.40
    end
    
    methods
        function obj = GeneticInvaderGeneLuminosity()
            obj = obj@GeneticInvaderGene();
            obj.setValue(GeneticInvaderGeneLuminosity.SEED);
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
            % enforce luminosity as sum of RGB >= 0 and <= 2.25
            if v > 2
                v = 2;
            elseif v < 0
                v = 0;
            end 
        end
    end
    
end
