function metaClass = getMetaClass(classInfo)
    % Returns a MetaClass object
    
    % ---------------------------------------------------------------------
    % Package   : singleton
    % Version   : 1.1
    % Author    : Evgeny Prilepin <esp.home@gmail.com>
    % Created   : 10.01.2013
    % Updated   : 05.04.2013
    %
    % Copyright : (C) 2013 by Evgeny Prilepin
    % ---------------------------------------------------------------------
    
    validateattributes(classInfo, {'char', 'meta.class'}, {}, ...
        mfilename, '"Class Info"', 1);
    
    if ischar(classInfo)
        metaClass = meta.class.fromName(classInfo);
    else
        metaClass = classInfo;
    end
    
    if isempty(metaClass)
        error('singleton:invalidClassInfo', ...
            'Not found or invalid specified class.')
    end
end
