classdef GeneticInvaderGeneColor < GeneticInvaderGene & handle

    properties (Constant)
        RGB_MAX = 1
        RGB_MIN = 0
        SEED = 0.5
    end

    methods
        function obj = GeneticInvaderGeneColor()
            obj = obj@GeneticInvaderGene();
            obj.setValue(GeneticInvaderGeneColor.SEED);
        end
        function setValue(obj, v)
            obj.value = obj.checkValue(v);
        end
        function v = getVariedValue(obj)
            randFactor = randn(1)/10 * 3;
            v = obj.value + (obj.value * randFactor);
            v = obj.checkValue(v);
        end        
    end
    
    methods (Access=private)
        function v = checkValue(~, v)
            % enforce RGB values >= 0 and <= 1
            if v > 1
                v = 1;
            elseif v < 0
                v = 0;
            end 
        end
    end
    
    methods (Static)
        function v = checkVector(v)
            ixMax = v > GeneticInvaderGeneColor.RGB_MAX;
            ixMin = v < GeneticInvaderGeneColor.RGB_MIN;
            v(ixMax) = GeneticInvaderGeneColor.RGB_MAX;
            v(ixMin) = GeneticInvaderGeneColor.RGB_MIN;                        
        end
    end
    
end
