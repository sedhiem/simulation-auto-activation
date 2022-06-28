classdef router3 < matlab.DiscreteEventSystem
    % untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a Discrete Event System object.

    % Public, tunable properties
    properties
        CacheTS_1_3 = 0; %ChainID:1, 3のキャッシュ
        CacheTS_2 = 0; %ChainID:2のキャッシュ
    end

    properties(Nontunable)
    % Capacity
        Capacity = 1;
    % Delay
        Delay = 0;
        routerID = 3;
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)

    end

    % Discrete-event algorithms
    methods
        function [entity,events] = entry(obj,~,entity,source)
            % Specify event actions when entity enters storage
            coder.extrinsic('fprintf');
            %source.typeはinput or strorage
            switch source.type
                case 'input'
                    % source.indexはInput or storage index
                    if source.index == 1
                        if entity.data.ChainID == 2
                            if obj.CacheTS_2 == 0
                                events = obj.eventForward('output', 1, 1);
                            else
                                entity.data.TimeStamp2 = obj.CacheTS_2;
                                entity.data.InterestData = 2;
                                events = obj.eventForward('output', 2, 1);
                            end
                        else
                            if obj.CacheTS_1_3 == 0
                                events = obj.eventForward('output', 1, 1);
                            else
                                entity.data.TimeStamp2 = obj.CacheTS_1_3;
                                events = obj.eventForward('output', 2, 1);
                            end
                        end
                    elseif source.index == 2
                        if entity.data.ChainID == 2
                            obj.CacheTS_2 = entity.data.TimeStamp2;
                        else
                            obj.CacheTS_1_3 = entity.data.TimeStamp2;
                        end
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

        function setupImpl(~)
            % Perform one-time calculations, such as computing constants
        end

        function resetImpl(~)
            % Initialize / reset discrete-state properties
        end

        function num = getNumInputsImpl(~)
            num = 2;
        end

        function num = getNumOutputsImpl(~)
            num = 2;
        end

        function name = getInputNamesImpl(~)
            % Return input port names for System block
            name = ["Int-in", "Data-in"];
        end

        function name = getOutputNamesImpl(~)
            % Return output port names for System block
            name = ["Int-out", "Data-out"];
        end

        function names = getSimulinkFunctionNamesImpl(~)
            % Return names of functions that will call Simulink
            % functions. For example, ["mySimulinkFunction", "myStateflowFunction"]
            names = "stampEntity";
        end
    end
end
