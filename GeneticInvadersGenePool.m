classdef GeneticInvadersGenePool < handle

    properties (Access=private)
        
        geneDensityObj
        
        geneColorRedObj
        geneColorGreenObj
        geneColorBlueObj
        
        geneLuminosityObj
        geneBoldnessObj
        
        geneYSpeedObj
        geneXSpeedObj
        geneJitterObj
        
    end
    
    methods
        function obj = GeneticInvadersGenePool()
            obj.createGenes();
        end
        
        function createGenes(obj)
            obj.geneColorRedObj = GeneticInvaderGeneColorRed();
            obj.geneColorGreenObj = GeneticInvaderGeneColorRed();
            obj.geneColorBlueObj = GeneticInvaderGeneColorRed();
            obj.geneLuminosityObj = GeneticInvaderGeneLuminosity();
            obj.geneDensityObj = GeneticInvaderGeneDensity();
            obj.geneBoldnessObj = GeneticInvaderGeneBoldness();
            obj.geneYSpeedObj = GeneticInvaderGeneYSpeed();
            obj.geneXSpeedObj = GeneticInvaderGeneXSpeed();
            obj.geneJitterObj = GeneticInvaderGeneJitter();
        end

        function mix(obj1, obj2)
            obj1.geneColorRedObj.inheritFrom(obj2.getColorRedGene());
            obj1.geneColorGreenObj.inheritFrom(obj2.getColorGreenGene());
            obj1.geneColorBlueObj.inheritFrom(obj2.getColorBlueGene());
            obj1.geneLuminosityObj.inheritFrom(obj2.getLuminosityGene());
            obj1.geneDensityObj.inheritFrom(obj2.getDensityGene());
            obj1.geneBoldnessObj.inheritFrom(obj2.getBoldnessGene());
            obj1.geneYSpeedObj.inheritFrom(obj2.getYSpeedGene());
            obj1.geneXSpeedObj.inheritFrom(obj2.getXSpeedGene());
            obj1.geneJitterObj.inheritFrom(obj2.getJitterGene());
        end
        
        function g = getDensityGene(obj)
            g = obj.geneDensityObj;
        end
        function g = getColorRedGene(obj)
            g = obj.geneColorRedObj;
        end      
        function g = getColorBlueGene(obj)
            g = obj.geneColorBlueObj;
        end                
        function g = getColorGreenGene(obj)
            g = obj.geneColorGreenObj;
        end 
        function g = getLuminosityGene(obj)
            g = obj.geneLuminosityObj;
        end  
        function g = getBoldnessGene(obj)
            g = obj.geneBoldnessObj;
        end
        function g = getYSpeedGene(obj)
            g = obj.geneYSpeedObj;
        end       
        function g = getXSpeedGene(obj)
            g = obj.geneXSpeedObj;
        end  
        function g = getJitterGene(obj)
            g = obj.geneJitterObj;
        end          
        function print(obj)
            fprintf(1,'Red: %.2f\n', obj.geneColorRedObj.getValue());
            fprintf(1,'Gr: %.2f\n', obj.geneColorGreenObj.getValue());
            fprintf(1,'Bl: %.2f\n', obj.geneColorBlueObj.getValue());
            fprintf(1,'Lum: %.2f\n', obj.geneLuminosityObj.getValue());
            fprintf(1,'Den: %.2f\n', obj.geneDensityObj.getValue());
            fprintf(1,'Bold: %.2f\n', obj.geneBoldnessObj.getValue());
            fprintf(1,'YSpeed: %.2f\n', obj.geneYSpeedObj.getValue());
            fprintf(1,'XSpeed: %.2f\n', obj.geneXSpeedObj.getValue());
            fprintf(1,'Jitter: %.2f\n', obj.geneJitterObj.getValue());
        end
    end % methods
    
end
