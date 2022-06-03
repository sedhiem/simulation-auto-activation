classdef functionProcess < matlab.DiscreteEventSystem
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
        function [entity,events] = entry(obj,storage,entity,source)
            % Specify event actions when entity enters storage
            events = obj.eventForward('output', 1, obj.Delay);
        end
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
