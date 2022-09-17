classdef router < matlab.DiscreteEventSystem
    % untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a Discrete Event System object.

    % Public, tunable properties
    properties
        CacheTS = 0;
    end

    properties(Nontunable)
    % Capacity
        Capacity = 1;
    % Delay
        Delay = 0;
        routerID = 2;
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)

    end

    % Discrete-event algorithms
    methods
        function [entity,events] = entry(obj,storage,entity,source)
            coder.extrinsic('fprintf');
            if source.type ~= "input" %source.typeはinput or strorage
                fprintf('Entry from storage\n');
                events = obj.eventDestroy();
                return;
            end
            if source.index == 1
                if obj.CacheTS == 0 
                    events = obj.eventForward('output', 1, 1);
                    return;
                end
                entity.data.TimeStamp2 = obj.CacheTS;
                if obj.routerID == 1
                    entity.data.timeStampRouter1 = obj.CacheTS;
                end
                if obj.routerID == 2
                    entity.data.timeStampRouter2 = obj.CacheTS;
                end
                if obj.routerID == 3
                    entity.data.timeStampRouter3 = obj.CacheTS;
                end
                events = obj.eventForward('output', 2, 1);
                return;
            end
            if source.index == 2
                obj.CacheTS = stampEntity();
                if entity.data.InterestData == 4 % 擬似コンシューマかどうか
                    events = obj.eventDestroy();
                    return;
                end
                if obj.routerID == 1
                    entity.data.timeStampRouter1 = obj.CacheTS;
                end
                if obj.routerID == 2
                    entity.data.timeStampRouter2 = obj.CacheTS;
                end
                if obj.routerID == 3
                    entity.data.timeStampRouter3 = obj.CacheTS;
                end
                events = obj.eventForward('output', 2, 1);
                return;
            end
            events = obj.eventDestroy();
            return;
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
            outputTypes = {'NDNPacket','NDNPacket'};
        end

        function [storageSpec,I,O] = getEntityStorageImpl(obj)
            % Return entity storage specification and connectivity
            % information from input ports and output ports to storage
            storageSpec = [ obj.queueFIFO('NDNPacket', obj.Capacity), ...
                obj.queueFIFO('NDNPacket', obj.Capacity)];
            I = {1, 2};
            O = {1, [1, 2]};
        end

        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end

        function num = getNumInputsImpl(obj)
            % Define total number of inputs for system with optional inputs
            num = 2;
            % if obj.UseOptionalInput
            %     num = 2;
            % end
        end

        function num = getNumOutputsImpl(obj)
            % Define total number of outputs for system with optional
            % outputs
            num = 2;
            % if obj.UseOptionalOutput
            %     num = 2;
            % end
        end

        function name = getInputNamesImpl(obj)
            % Return input port names for System block
            name = ["Int-in", "Data-in"];
        end

        function name = getOutputNamesImpl(obj)
            % Return output port names for System block
            name = ["Int-out", "Data-out"];
        end

        function names = getSimulinkFunctionNamesImpl(obj)
            % Return names of functions that will call Simulink
            % functions. For example, ["mySimulinkFunction", "myStateflowFunction"]
            names = "stampEntity";
        end
    end
end
