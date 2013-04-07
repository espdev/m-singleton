function r = registry()
    % Returns singleton instance for registry of singletons
    %
    % Usage:
    %   registry = singleton.registry()
    %
    % Returns:
    %   registry -- global registry (singleton instance of
    %               singleton.SingletonRegistry class)
    %
    %
    % See also: singleton.SingletonRegistry.getRegistry
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
    
    r = singleton.SingletonRegistry.getRegistry();
end
