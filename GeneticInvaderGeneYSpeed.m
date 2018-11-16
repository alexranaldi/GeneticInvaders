classdef GeneticInvaderGeneYSpeed < GeneticInvaderGene & handle

    properties (Constant)
        % seed speed is 10 pixels/sec
        SEED = 10
    end

    methods
        function obj = GeneticInvaderGeneYSpeed()
            obj = obj@GeneticInvaderGene();
            obj.setValue(GeneticInvaderGeneYSpeed.SEED);
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
            % enforce speed values >= 2 and <= 60
            if v < 2
                v = 2;
            elseif v > 60
                v = 60;
            end 
        end
    end
    
end
