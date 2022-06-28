classdef coordinatorRouter2 < matlab.DiscreteEventSystem
    % untitled2 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a Discrete Event System object.

    % Public, tunable properties
    properties

    end

    properties(Nontunable)
        Capacity = 1;
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
            % Consumer1の条件 || Consumer2の条件
            if rem(stampEntity() - 1, 7) == 0 || rem(stampEntity() - 5, 7) == 0
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

        function num = getNumInputsImpl(~)
            % Define total number of outputs for system with optional
            num = 2;
        end

        function num = getNumOutputsImpl(~)
            % Define total number of outputs for system with optional
            num = 2;
        end

        function entityTypes = getEntityTypesImpl(obj)
            % Return entity type structures with fields specifying
            % properties such as name, size, data type, and complexity
            entityTypes = obj.entityType('StartPseudoConsumer');
        end

        function [storageSpec,I,O] = getEntityStorageImpl(obj)
            % Return entity storage specification and connectivity
            % information from input ports and output ports to storage
            storageSpec = obj.queueFIFO('StartPseudoConsumer', obj.Capacity);
            I = {1, 1};
            O = {1, 1};
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
