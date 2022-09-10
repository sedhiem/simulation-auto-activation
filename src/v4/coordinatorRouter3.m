classdef coordinatorRouter3 < matlab.DiscreteEventSystem
    % untitled2 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a Discrete Event System object.

    % Public, tunable properties
    properties

    end

    properties(Nontunable)
        routerID = 1;
        delay = 1;
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)

    end

    % Discrete-event algorithms
    methods
        function [entity,events] = entry(obj,~,entity,~)
            % Consumer1の条件 || Consumer2の条件 || Consumer3の条件
            if rem(stampEntity() + 4 - 1 - 4 - 1 - 7, 15) == 0 || rem(stampEntity() + 6 - 1 - 7, 12) == 0 || rem(stampEntity() + 1 + 1 + 7, 7) == 0
                events = obj.eventForward('output', 1, 1);
            else
                events = obj.eventDestroy(); 
            end
        end
    end

    methods(Access = protected)
        function setupImpl(~)
            % Perform one-time calculations, such as computing constants
        end

        function resetImpl(~)
            % Initialize / reset discrete-state properties
        end

        function num = getNumOutputsImpl(~)
            % Define total number of outputs for system with optional
            num = 1;
        end

        function hasThreshold = calcThreshold(~)
            hasThreshold = true;
        end

        function names = getSimulinkFunctionNamesImpl(~)
            % Return names of functions that will call Simulink
            % functions. For example, ["mySimulinkFunction", "myStateflowFunction"]
            names = "stampEntity";
        end
    end
end
