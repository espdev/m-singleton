function deleteAllInstances()
    % Destroys all singleton instances
    %
    % Usage:
    %   singleton.deleteAllInstances()
    %
    % Example:
    %   map = singleton.getInstance(?containers.Map)
    %   p = singleton.getInstance(?inputParser)
    %   singleton.deleteAllInstances()
    %   p
    %   map
    %
    %
    % See also: singleton.deleteInstance, singleton.SingletonFactory.deleteAllInstances
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
    
    singleton.SingletonFactory.deleteAllInstances();
end
