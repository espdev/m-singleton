function setup()
    
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
