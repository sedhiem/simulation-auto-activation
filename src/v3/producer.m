classdef producer < matlab.DiscreteEventSystem
    % untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a Discrete Event System object.

    % Public, tunable properties
    properties

    end

    properties(Nontunable)
        Capacity = 1;
        Delay = 1;
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)

    end

    % Discrete-event algorithms
    methods
        function [entity,events] = entry(obj,~,entity,~)
            % Specify event actions when entity enters storage
            entity.data.TimeStamp2 = stampEntity();
            events = obj.eventForward('output', 1, obj.Delay);
        end
    end

    methods(Access = protected)
        function entityTypes = getEntityTypesImpl(obj)
            % Return entity type structures with fields specifying
            % properties such as name, size, data type, and complexity
            entityTypes = obj.entityType('NDNPacket');
        end

        function [inputTypes,outputTypes] = getEntityPortsImpl(~)
            % Specify entity input and output ports. Return entity types at
            % a port as strings in a cell array. Use empty string to
            % indicate a data port.
            inputTypes = {'NDNPacket','NDNPacket'};
            outputTypes = {'NDNPacket'};
        end

        function [storageSpec,I,O] = getEntityStorageImpl(obj)
            % Return entity storage specification and connectivity
            % information from input ports and output ports to storage
            storageSpec = obj.queueFIFO('NDNPacket', obj.Capacity);
            I = 2;
            O = 1;
        end

        function setupImpl(~)
            % Perform one-time calculations, such as computing constants
        end

        function resetImpl(~)
            % Initialize / reset discrete-state properties
        end

        function num = getNumInputsImpl(~)
            % Define total number of inputs for system with optional inputs
            num = 2;
            % if obj.UseOptionalInput
            %     num = 2;
            % end
        end

        function num = getNumOutputsImpl(~)
            % Define total number of outputs for system with optional
            % outputs
            num = 1;
            % if obj.UseOptionalOutput
            %     num = 2;
            % end
        end

        function names = getSimulinkFunctionNamesImpl(~)
            % Return names of functions that will call Simulink
            % functions. For example, ["mySimulinkFunction", "myStateflowFunction"]
            names = "stampEntity";
        end
    end
end
