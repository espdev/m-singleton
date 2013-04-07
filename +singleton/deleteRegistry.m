function deleteRegistry()
    % Destroys the global registry and all singleton instances
    %
    % Usage:
    %   singleton.deleteRegistry()
    %
    % Example:
    %   map = singleton.getInstance(?containers.Map)
    %   r = singleton.registry()
    %
    %   % This will not delete the global registry!
    %   clear functions
    %   clear classes
    %   clear global
    %
    %   r = singleton.registry() % registry has not been cleared!
    %   singleton.countInstances()
    %
    %   % This will destroy the global registry and clear memory
    %   singleton.deleteRegistry()
    %
    %   r % deleted
    %   singleton.countInstances()
    %
    %
    % See also: singleton.deleteInstance, singleton.deleteAllInstances
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
    delete(r);
end
