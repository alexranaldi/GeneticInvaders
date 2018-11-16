classdef GeneticInvaderGeneJitter < GeneticInvaderGene & handle

    properties (Constant)
        % units are jitters per second
        SEED = 0.12;
    end

    methods
        function obj = GeneticInvaderGeneJitter()
            obj = obj@GeneticInvaderGene();
            obj.setValue(GeneticInvaderGeneJitter.SEED);
        end
        function setValue(obj, v)
            obj.value = obj.checkValue(v);
        end
        function v = getVariedValue(obj)
            randFactor = randn(1)/10 * 4;
            v = obj.value + (obj.value * randFactor);
            v = obj.checkValue(v);
        end        
        function v = getValue(obj)
            v = obj.value;
        end                    
    end
    
    methods (Access=private)
        function v = checkValue(~, v)
            if v <= 0
                v = 0;
            elseif v > 1.5
                v = 1.5;
            end 
        end
    end
    
end
