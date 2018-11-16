classdef GeneticInvaderGeneBoldness < GeneticInvaderGene & handle

    properties (Constant)
        SEED = 2
    end
    
    methods
        function obj = GeneticInvaderGeneBoldness()
            obj = obj@GeneticInvaderGene();
            obj.setValue(GeneticInvaderGeneBoldness.SEED);
        end
        function v = getValue(obj)
            v = fix(0.5 + obj.value);
        end
        function setValue(obj, d)
            obj.value = obj.checkValue(d);
        end
        function v = getVariedValue(obj)
            randFactor = randn(1)/10 * 2;
            v = obj.value + (obj.value * randFactor);
            v = obj.checkValue(v);
        end
    end
    
    methods (Access=private)
        function v = checkValue(~, v)
            % enforce boldness 1-4
            if v > 4
                v = 4;
            elseif v < 1
                v = 1;
            end 
        end
    end
end
