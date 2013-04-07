function deleteInstance(classInfo)
    % Destroys the singleton instance of a given class
    %
    % Usage:
    %   singleton.deleteInstance(classInfo)
    %
    % Arguments:
    %   classInfo -- Name or meta.class object of a given class.
    %
    % Example:
    %   imshow('cameraman.tif');
    %   line = singleton.getInstance(?imline, gca, [10 100], [30, 80])
    %   singleton.deleteInstance(?imline)
    %
    %
    % See also: singleton.deleteAllInstances, singleton.SingletonFactory.deleteInstance
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

    singleton.SingletonFactory.deleteInstance(classInfo);
end
