classdef (Sealed) SingletonFactory < handle
    % Factory for create singleton-instances of any classes
    %
    % Description:
    %   This class creates singleton instances of any classes (creates 
    %   global objects).
    %   
    %   Created instances will be stored in SingletonRegistry global object.
    %
    % Usage:
    %   instance = SingletonFactory.getInstance(?ClassName)
    %   instance = SingletonFactory.getInstance('ClassName')
    %
    % where
    %   ?ClassName  -- Meta class object of given class
    % 	'ClassName' -- Name of given class
    %
    %
    % See also: SingletonRegistry
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
    
    methods (Access = private)
        
        function self = SingletonFactory()
            % Instance of "SingletonFactory" is not needed.
            % Provides only static methods.
        end
        
    end
    
    
    methods (Static)
        
        %------------------------------------------------------------------
        function instance = getInstance(classInfo, varargin)
            % Returns a reference on singleton instance of given class
            %
            % Description:
            %   This factory method returns a reference on singleton 
            %   instance of given class. If instance is not exist, 
            %   method creates it.
            %
            % Usage:
            %   instance = SingletonFactory.getInstance(classInfo)
            %   instance = SingletonFactory.getInstance(classInfo, varargin)
            %
            % Arguments:
            %   classInfo -- Info about class: Name or meta.class object.
            %   varargin  -- Class constructor arguments . Will be set to
            %                given class constructor if it is created.
            %
            % Return:
            %   instance  -- Reference on singleton instance of given class
            %
            
            narginchk(1, Inf)
            
            metaClass = getMetaClass(classInfo);
            r = singleton.registry();
            
            if r.hasInstance(metaClass.Name)
                instance = r.getInstance(metaClass.Name);
            else
                instance = singleton.SingletonFactory.createInstance(metaClass, varargin{:});
                r.addInstance(instance);
            end
        end
        
        %------------------------------------------------------------------
        function deleteInstance(classInfo)
            % Destroys a singleton instance of given class
            %
            % Usage:
            %   SingletonFactory.deleteInstance(classInfo)
            %
            % Arguments:
            %   classInfo -- Info about class: Name or meta.class object.
            %
            % See also: deleteAllInstances
            %
            
            narginchk(1, 1)
            
            metaClass = getMetaClass(classInfo);
            r = singleton.registry();
            
            r.deleteInstance(metaClass.Name);
        end
        
        %------------------------------------------------------------------
        function deleteAllInstances()
            % Destroys all stored instances
            %
            % Description:
            %   This method destroys all singleton instances stored in 
            %   SingletonRegistry            
            %
            % Usage:
            %   SingletonFactory.deleteAllInstances()
            %
            % See also: deleteInstance
            %
            
            r = singleton.registry();
            r.deleteAllInstances();
        end
        
    end % Static Methods
    
    
    methods (Static, Access = private)
        
        %------------------------------------------------------------------
        function instance = createInstance(metaClass, varargin)
            % Creates an instance of given class
            
            if ~isHandleClass(metaClass)
                error('singleton:notHandleClass', ...
                    'Class "%s" is not handle class. Class must be subclass of handle class.', ...
                    metaClass.Name)
            end
            
            try
                constructInstance = str2func(metaClass.Name);
                instance = constructInstance(varargin{:});
            catch e
                error('singleton:createFailed', ...
                    'Unable to create instance of class "%s".\n%s', ...
                    metaClass.Name, e.message)
            end
        end
        
    end % Static Private Methods
    
end % SingletonFactory
