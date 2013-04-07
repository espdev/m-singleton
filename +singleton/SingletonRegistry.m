classdef (Sealed) SingletonRegistry < handle
    % Class is the global registry for store singleton instances
    %
    % Description:
    %   A class is singleton registry and is used to store instances
    %   of class, that must exist as a singleton.
    %
    %   To create, add, delete of instances must be used SingletonFactory class
    %
    % Usage:
    %   registry = SingletonRegistry.getRegistry()
    %
    %   registry.Count
    %   registry.getAllInstances()
    %
    %
    % See also: SingletonFactory
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
    
    properties (Dependent)
        
        Count       % Number of stored instances
        
    end
    
    properties (Access = private)
        
        Instances   % Map stores instances of classes
        
    end
    
    
    methods (Access = private)
        
        %------------------------------------------------------------------
        function self = SingletonRegistry()
            % Private constructor of singleton class SingletonRegistry
            
            self.Instances = containers.Map('KeyType', 'char', 'ValueType', 'any');
        end
        
        %------------------------------------------------------------------
        function removeDestroyedInstance(self, destroyedObject)
            % Removes an instance to be destroyed
            
            className = class(destroyedObject);
            
            if self.hasInstance(className)
                self.Instances.remove(className);
            end
        end
        
    end % Private Methods
    
    
    methods (Access = ?singleton.SingletonFactory)
        
        %------------------------------------------------------------------
        function addInstance(self, object)
            % Adds new instance to registry
            %
            % Description:
            %   Adds created instance to singleton registry.
            %
            %   Method can be called only from SingletonFactory.
            %
            % See also: deleteInstance
            %
            
            className = class(object);
            
            if ~self.hasInstance(className)
                self.Instances(className) = object;
                
                addlistener(object, 'ObjectBeingDestroyed', ...
                    @(src, evnt) self.removeDestroyedInstance(src));
            end
        end
        
        %------------------------------------------------------------------
        function deleteInstance(self, className)
            % Removes an instance of given class from registry and destroys it
            %
            % Description:
            %   This method removes an instance of given class from registry 
            %   and destroys it (calls the destructor of instance).
            %   
            %   It is considered that instance created by means of SingletonFactory
            %   can't separately exist from SingletonRegistry.
            %
            %   Method can be called only from SingletonFactory.
            %
            % See also: addInstance
            %
            
            if self.hasInstance(className)
                object = self.Instances(className);
                delete(object);
            end
        end
        
        %------------------------------------------------------------------
        function deleteAllInstances(self)
            % Removes all instances from registry
            %
            % Description:
            %   This method removes all instances from registry 
            %   and destroys them (calls the destructor of instances).
            %
            %   Method can be called only from SingletonFactory.
            %
            
            cellfun(@(x) delete(x), self.getAllInstances());
        end
        
    end % Access = ?singleton.SingletonFactory
    
    
    methods (Access = public)
        
        %------------------------------------------------------------------
        function object = getInstance(self, classInfo)
            % Returns instance of given class
            %
            % Description:
            %   This method returns instance of given class.
            %   Returns [] if instance is not exists.
            %
            % Usage:
            %   instance = obj.getInstance(?ClassName)
            %   instance = obj.getInstance('ClassName')
            %
            % Arguments:
            %   ?ClassName  -- MetaClass object
            %   'ClassName' -- Name of class
            %
            % See also: SingletonFactory.getInstance
            %
            
            narginchk(2, 2)
            
            if self.hasInstance(classInfo)
                metaClass = getMetaClass(classInfo);
                object = self.Instances(metaClass.Name);
            else
                object = [];
            end
        end
        
        %------------------------------------------------------------------
        function tf = hasInstance(self, classInfo)
            % Returns true if instance of given class is exists
            %
            % Usage:
            %   tf = obj.hasInstance(?ClassName)
            %   tf = obj.hasInstance('ClassName')
            %
            % Arguments:
            %   ?ClassName  -- MetaClass object
            %   'ClassName' -- Name of class
            %
            
            narginchk(2, 2)
            
            metaClass = getMetaClass(classInfo);
            tf = self.Instances.isKey(metaClass.Name);
        end
        
        %------------------------------------------------------------------
        function instances = getAllInstances(self)
            % Returns all stored instances in cell array
            
            narginchk(1, 1)
            instances = self.Instances.values();
            instances = instances(:);
        end
        
        %------------------------------------------------------------------
        function classes = getAllClasses(self)
            % Returns all metaclass objects in cell array
            
            narginchk(1, 1)
            
            classes = cellfun(@(x) meta.class.fromName(x), self.Instances.keys(), ...
                'UniformOutput', false);
            classes = classes(:);
        end
        
        %------------------------------------------------------------------
        function delete(self)
            % Removes and destroys registry and all instances from memory
            
            self.unlock();
            self.deleteAllInstances();
            
            delete@handle(self);
        end
        
    end % Public API Methods
    
    
    methods (Static)
        
        %------------------------------------------------------------------
        function registry = getRegistry()
            % Returns a reference on singleton instance of registry
            
            if ~mislocked('SingletonRegistry')
                % Lock singleton object for guard
                mlock
            end
            
            persistent instance
            
            if (isempty(instance) || ~isvalid(instance))
                instance = singleton.SingletonRegistry();
            end
            
            registry = instance;
        end
        
        %------------------------------------------------------------------
        function unlock()
            % Unlock object, that allows you to remove global singleton from memory
            
            if mislocked('SingletonRegistry')
                munlock('SingletonRegistry')
            end
        end
        
    end % Static Methods
    
    
    methods
        
        function value = get.Count(self)
            value = length(self.Instances);
        end
        
    end
    
end % SingletonRegistry
