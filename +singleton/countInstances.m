function count = countInstances()
    % Returns the number of the existing singleton instances
    %
    % Usage:
    %   count = singleton.countInstances()
    %
    % Returns:
    %   count -- The number of the existing singleton instances
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
