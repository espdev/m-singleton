function tf = isHandleClass(metaClass)
    % Returns true if a given class is a handle class

    % ---------------------------------------------------------------------
    % Package   : singleton
    % Version   : 1.1
    % Author    : Evgeny Prilepin <esp.home@gmail.com>
    % Created   : 10.01.2013
    % Updated   : 05.04.2013
    %
    % Copyright : (C) 2013 by Evgeny Prilepin
    % ---------------------------------------------------------------------

    superClasses = metaClass.SuperclassList;

    if isempty(superClasses)
        tf = false;
        return
    end

    tf = ismember('handle', {metaClass.SuperclassList.Name});

    if ~tf
        for i = 1:length(superClasses)
            tf = isHandleClass(superClasses(i));
        end
    end
end
