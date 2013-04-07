function instance = getInstance(classInfo, varargin)
    % Returns singleton instance of  a given class
    %
    % If the instance does not exist, then the function will create it.
    %
    % Usage:
    %   instance = singleton.getInstance(classInfo)
    %   instance = singleton.getInstance(classInfo, varargin)
    %
    % Arguments:
    %   classInfo -- Name or meta.class object of a given class.
    %   varargin  -- Any arguments required for a given class.
    %
    % Returns:
    %   instance  -- singleton instance of a given class.
    %
    % Example:
    %   parser = singleton.getInstance(?inputParser)
    %   map = singleton.getInstance(?containers.Map, 'KeyType', 'char', 'ValueType', 'double')
    %
    %
    % See also: singleton.hasInstance, singleton.SingletonFactory.getInstance
    %

    % ---------------------------------------------------------------------
    % Package   : singleton
    % Version   : 1.1
    % Author    : Evgeny Prilepin <esp.home@gmail.com>
    % Created   : 10.01.2013
    % Updated   : 05.04.2013
    %
    % Copyright : (C) 2013 by Evgeny Prilepin
    % ---------------------------------------------------------------------

    instance = singleton.SingletonFactory.getInstance(classInfo, varargin{:});
end
