function instances = getAllInstances()
    % Returns all singleton instances in cell array
    %
    % Usage:
    %   instances = singleton.getAllInstances()
    %
    % Returns:
    %   instances -- cell array of all singleton instances
    %
    %
    % See also: singleton.getInstance, singleton.SingletonFactory.getAllInstances
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
    
    r = singleton.registry();
    instances = r.getAllInstances();
end