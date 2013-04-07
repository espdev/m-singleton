classdef SimpleProtectedClass < handle
    % Simple example of a protected class
    %
    % The instance of this class must be created only in singleton.SingletonFactory class.
    %

    properties

        Value = 0

    end

    methods (Access = ?singleton.SingletonFactory)

        function self = SimpleProtectedClass(value)
            % Protected constructor

            if (nargin == 1)
                self.Value = value;
            end
        end

    end

end % SimpleProtectedClass
