classdef coordinatorRouter2 < matlab.DiscreteEventSystem
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
        function [entity,events] = entry(obj,storage,entity,source)
            % 定数
            if rem(stampEntity() - 1, 7) == 0 || rem(stampEntity() - 5, 7) == 0
                events = obj.eventForward('output', 1, 1);
            else
                events = obj.eventDestroy(); 
            end
        end
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function resetImpl(obj)
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
