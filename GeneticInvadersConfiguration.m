classdef GeneticInvadersConfiguration

    % Graphics
    properties (Constant)
        DEFAULT_INVADER_COLOR = [0 0 0];
        DEFAULT_MAX_X = 120
        DEFAULT_MAX_Y = 250
        DEFAULT_SHIP_WIDTH = 12
        DEFAULT_SHIP_HEIGHT = 1
        DEFAULT_SHIP_Y = 2
        DEFAULT_INVADER_LENGTH = 6
    end
    
    properties (SetAccess=private)
        invaderColor
        maxX
        maxY
        shipHeight
        shipWidth
        shipY
        invaderLength
    end
    
    methods
        function obj = GeneticInvadersConfiguration()
            obj.invaderColor =      GeneticInvadersConfiguration.DEFAULT_INVADER_COLOR;
            obj.maxX =              GeneticInvadersConfiguration.DEFAULT_MAX_X;
            obj.maxY =              GeneticInvadersConfiguration.DEFAULT_MAX_Y;
            obj.shipHeight =        GeneticInvadersConfiguration.DEFAULT_SHIP_HEIGHT;
            obj.shipWidth =         GeneticInvadersConfiguration.DEFAULT_SHIP_WIDTH;
            obj.shipY =             GeneticInvadersConfiguration.DEFAULT_SHIP_Y;
            obj.invaderLength =     GeneticInvadersConfiguration.DEFAULT_INVADER_LENGTH;
        end
    end
    
end
