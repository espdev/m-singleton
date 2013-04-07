function count = countInstances()
    % Returns number of exists singleton instances
    %
    % Usage:
    %   count = singleton.countInstances()
    %
    % Returns:
    %   count -- Number of exists singleton instances
    %
    % Example:
    %   map = singleton.getInstance(?containers.Map)
    %   singleton.countInstances()
    %   singleton.deleteAllInstances()
    %   singleton.countInstances()
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
    count = r.Count;
end
