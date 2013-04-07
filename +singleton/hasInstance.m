function tf = hasInstance(classInfo)
    % Returns true if instance of given class is exists as singleton
    %
    % Usage:
    %   tf = singleton.hasInstance(classInfo)
    %
    % Arguments:
    %   instance = singleton.getInstance(classInfo)
    %
    % Returns:
    %   tf -- true if instance of given class is exists
    %
    % Example:
    %   singleton.hasInstance(?containers.Map)
    %   map = singleton.getInstance(?containers.Map)
    %   singleton.hasInstance(?containers.Map)
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
    tf = r.hasInstance(classInfo);
end
