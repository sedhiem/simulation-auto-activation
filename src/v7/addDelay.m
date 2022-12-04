classdef addDelay < matlab.DiscreteEventSystem
    % untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a Discrete Event System object.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)

    end

    properties(Nontunable)
        Delay = 1;
    end

    % Pre-computed constants
    properties(Access = private)

    end

    % Discrete-event algorithms
    methods
        function [entity,events] = entry(obj,~,entity,~)
            % Specify event actions when entity enters storage
            events = obj.eventForward('output', 1, obj.Delay);
        end
    end

    methods(Access = protected)
        function setupImpl(~)
            % Perform one-time calculations, such as computing constants
        end

        function resetImpl(~)
            % Initialize / reset discrete-state properties
        end
    end
end
