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
            % Specify event actions when entity enters storage
            % disp(['Entity of ID ' num2str(entity.sys.id) ' has entered storage element ' num2str(storage)]);
            coder.extrinsic('fprintf');
            %fprintf('At time %d entity of ID %d of ChainID %d has entered storage element %d at router %d\n', stampEntity(), int64(entity.sys.id), entity.data.ChainID, int64(storage), obj.routerID);
            %source.typeはinput or strorage
            switch source.type
                case 'input'
                    % source.indexはInput or storage index
                    if source.index == 1 %inputの1 Consumer1
                        if obj.CacheTS == 0 %キャッシュされているものがない
                            %eventForward('storage or output', port index, delay)
                            events = obj.eventForward('output', 1, 1);
                        else
                            entity.data.TimeStamp2 = obj.CacheTS;
                            if entity.data.InterestData == 1
                                entity.data.InterestData = 2;
                            elseif entity.data.InterestData == 2
                                entity.data.InterestData = 3;
                            end
                            events = obj.eventForward('output', 2, 1);
                        end
                    elseif source.index == 2 %inputの2
                        obj.CacheTS = entity.data.TimeStamp2;
                        % 擬似コンシューマかどうか
                        if entity.data.InterestData == 4
                            events = obj.eventDestroy();
                        else
                            events = obj.eventForward('output', 2, 1);
                        end
                    else
                        events = obj.eventDestroy();
                    end
                otherwise
                    fprintf('Entry from storage\n');
                    events = obj.eventDestroy();
            end
        end
    end

    methods(Access = protected)
        function entityTypes = getEntityTypesImpl(obj)
            % Return entity type structures with fields specifying
            % properties such as name, size, data type, and complexity
            entityTypes = obj.entityType('NDNPacket');
        end

        function [inputTypes,outputTypes] = getEntityPortsImpl(obj)
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
