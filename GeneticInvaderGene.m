classdef GeneticInvaderGene < handle

    properties (Access=protected)
        value
    end
    
    methods
        function obj = GeneticInvaderGene()

        end
        function v = getValue(obj)
            v = obj.value;
        end            
        function inheritFrom(obj, geneObj)
            mixValue = geneObj.getValue();
            newValue = (obj.value + mixValue) / 2;
            obj.setValue(newValue);
        end        
    
    end

end
