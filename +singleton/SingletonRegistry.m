classdef (Sealed) SingletonRegistry < handle
    % Class is a global registry for the store of singleton instances
    %
    % Description:
    %   Class is singleton registry and is used to store instances
    %   of classes, that must exist as a singleton.
    %
    %   SingletonFactory class must be used to create, add, and delete instances.
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
            % Private constructor creates the singleton instance of SingletonRegistry class

            self.Instances = containers.Map('KeyType', 'char', 'ValueType', 'any');
        end

        %------------------------------------------------------------------
        function removeDestroyedInstance(self, destroyedObject)
            % Remove the destroyed instance

            className = class(destroyedObject);

            if self.hasInstance(className)
                self.Instances.remove(className);
            end
        end

    end % Private Methods


    methods (Access = ?singleton.SingletonFactory)

        %------------------------------------------------------------------
        function addInstance(self, object)
            % Adds a new instance to registry
            %
            % Description:
            %   Adds the created instance to singleton registry.
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
            % Deletes the instance of a given class from registry and destroys it
            %
            % Description:
            %   This method deletes the instance of a given class from registry
            %   and destroys it (calls the instance destructor).
            %
            %   It is considered as an instance created by means of SingletonFactory
            %   and it can't exist separately from SingletonRegistry.
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
            %   and destroys them (calls the instances destructor).
            %
            %   Method can be called only from SingletonFactory.
            %

            cellfun(@(x) delete(x), self.getAllInstances());
        end

    end % Access = ?singleton.SingletonFactory


    methods (Access = public)

        %------------------------------------------------------------------
        function object = getInstance(self, classInfo)
            % Returns the instance of a given class
            %
            % Description:
            %   This method returns the instance of a given class.
            %   Returns [] if the instance does not exist.
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
            % Returns true if the instance of a given class exists
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
            % Returns all stored instances in the cell array

            narginchk(1, 1)
            instances = self.Instances.values();
            instances = instances(:);
        end

        %------------------------------------------------------------------
        function classes = getAllClasses(self)
            % Returns all metaclass objects in the cell array

            narginchk(1, 1)

            classes = cellfun(@(x) meta.class.fromName(x), self.Instances.keys(), ...
                'UniformOutput', false);
            classes = classes(:);
        end

        %------------------------------------------------------------------
        function delete(self)
            % Removes and destroys the registry and all instances from the memory

            self.unlock();
            self.deleteAllInstances();

            delete@handle(self);
        end

    end % Public API Methods


    methods (Static)

        %------------------------------------------------------------------
        function registry = getRegistry()
            % Returns the reference to registry singleton instance

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
            % Object unlock allows the global singleton removing from the memory

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
