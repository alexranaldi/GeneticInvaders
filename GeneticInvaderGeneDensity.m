classdef GeneticInvaderGeneDensity < GeneticInvaderGene & handle

    properties (Constant)
        MAX = 36
        SEED = 24
    end

    methods
        function obj = GeneticInvaderGeneDensity()
            obj = obj@GeneticInvaderGene();
            obj.setValue(GeneticInvaderGeneDensity.SEED);
        end
        function setValue(obj, d)
            obj.value = obj.checkValue(d);
        end
        function v = getVariedValue(obj)
            randFactor = randn(1)/10 * 2.25;
            v = obj.value + (obj.value * randFactor);
            v = obj.checkValue(v);
        end         
    end
    
    methods (Access=private)
        function v = checkValue(~, v)
            % enforce density values >= 1 and <= 36
            if v > GeneticInvaderGeneDensity.MAX
                v = GeneticInvaderGeneDensity.MAX;
            elseif v < 1
                v = 1;
            end 
        end
    end
end
