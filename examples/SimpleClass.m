classdef SimpleClass < handle
    % Simple example of a class

    properties

        Value = 0

    end

    methods

        function self = SimpleClass(value)

            if (nargin == 1)
                self.Value = value;
            end
        end

    end

end % SimpleClass
