function setup()
    % Install and uninstall singleton package
    %
    % Usage:
    %   setup()
    %
    % Input commands:
    %   - install   : Add package directories to MATLAB search paths
    %   - uninstall : Remove package directories from MATLAB search paths
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

    action = input('Setup: [Install]/Uninstall:', 's');

    if isempty(action)
        action = 'i';
    end

    action = validatestring(action, {'install', 'uninstall'});

    d = fileparts(mfilename('fullpath'));

    p = {
        d
        fullfile(d, 'examples')
        fullfile(d, 'tests')
        };

    switch action
        case 'install'
            addpath(p{:});
            disp('install done');

        case 'uninstall'
            cellfun(@(x) rmpath(x), p);
            disp('uninstall done');
    end

	savepath();
end
