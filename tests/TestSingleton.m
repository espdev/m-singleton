classdef TestSingleton < matlab.unittest.TestCase
    % Testing of SingletonFactory/SingletonRegistry
    
    methods (TestMethodTeardown)
        
        function destroySingletons(~)
            r = singleton.SingletonRegistry.getRegistry();
            delete(r);
        end
        
    end
    
    
    methods (Test)
        
        %------------------------------------------------------------------
        function testFactoryCreate(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            obj2 = singleton.SingletonFactory.getInstance(?SimpleClass);
            
            verifyEqual(self, obj1, obj2)
        end
        
        %------------------------------------------------------------------
        function testFactoryNotHandleClass(self)
            
            f = @() singleton.SingletonFactory.getInstance(?struct);
            
            verifyError(self, f, 'singleton:notHandleClass')
        end
        
        %------------------------------------------------------------------
        function testFactoryInvalidClass(self)
            
            f = @() singleton.SingletonFactory.getInstance('notexistsclass');
            
            verifyError(self, f, 'singleton:invalidClassInfo')
        end
        
        %------------------------------------------------------------------
        function testFactoryCreateError(self)
            
            f = @() singleton.SingletonFactory.getInstance(?SimpleClass, 1, 2);
            
            verifyError(self, f, 'singleton:createFailed')
        end
        
        %------------------------------------------------------------------
        function testFactoryPassArguments(self)
            
            obj = singleton.SingletonFactory.getInstance(?SimpleClass, 10);
            
            verifyEqual(self, obj.Value, 10)
        end
        
        %------------------------------------------------------------------
        function testFactoryDestroy(self)
            
            obj = singleton.SingletonFactory.getInstance(?SimpleProtectedClass);
            r = singleton.SingletonRegistry.getRegistry();
            
            c1 = r.Count;
            singleton.SingletonFactory.deleteInstance(?SimpleProtectedClass);
            c2 = r.Count;
            
            verifyEqual(self, {isvalid(obj), c1, c2}, {false, 1, 0})
        end
        
        %------------------------------------------------------------------
        function testFactoryDestroyAll(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            obj2 = singleton.SingletonFactory.getInstance(?SimpleProtectedClass);
            
            singleton.SingletonFactory.deleteAllInstances();
            r = singleton.SingletonRegistry.getRegistry();
            
            verifyEqual(self, ...
                {isvalid(obj1) isvalid(obj2) isvalid(r) r.Count}, {false false true 0})
        end
        
        %------------------------------------------------------------------
        function testRegistrySingleton(self)
            
            r1 = singleton.SingletonRegistry.getRegistry();
            r2 = singleton.SingletonRegistry.getRegistry();
            
            verifyEqual(self, r1, r2)
        end
        
        %------------------------------------------------------------------
        function testRegistryDestroy(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            obj2 = singleton.SingletonFactory.getInstance(?SimpleProtectedClass);
            
            r = singleton.SingletonRegistry.getRegistry();
            delete(r)
            
            verifyEqual(self, ...
                [isvalid(obj1) isvalid(obj2) isvalid(r)], [false false false])
        end
        
        %------------------------------------------------------------------
        function testRegistryCount(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            obj2 = singleton.SingletonFactory.getInstance(?SimpleProtectedClass);
            
            r = singleton.SingletonRegistry.getRegistry();
            
            verifyEqual(self, r.Count, 2)
        end
        
        %------------------------------------------------------------------
        function testRegistryGetInstance(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            
            r = singleton.SingletonRegistry.getRegistry();
            instance = r.getInstance('SimpleClass');
            
            verifyEqual(self, obj1, instance)
        end
        
        %------------------------------------------------------------------
        function testRegistryHasInstance(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            
            r = singleton.SingletonRegistry.getRegistry();
            tf(1) = r.hasInstance('SimpleClass');
            tf(2) = r.hasInstance('SimpleProtectedClass');
            
            verifyEqual(self, tf, [true false])
        end
        
        %------------------------------------------------------------------
        function testRegistryGetAllInstances(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            obj2 = singleton.SingletonFactory.getInstance(?SimpleProtectedClass);
            
            r = singleton.SingletonRegistry.getRegistry();
            instances = r.getAllInstances();
            
            verifyEqual(self, instances, {obj1; obj2})
        end
        
        %------------------------------------------------------------------
        function testRegistryGetAllClasses(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            obj2 = singleton.SingletonFactory.getInstance(?SimpleProtectedClass);
            
            r = singleton.SingletonRegistry.getRegistry();
            classes = r.getAllClasses();
            
            verifyEqual(self, classes, {?SimpleClass; ?SimpleProtectedClass})
        end
        
        %------------------------------------------------------------------
        function testRegistryRemoveDestroyedInstance(self)
            
            obj1 = singleton.SingletonFactory.getInstance(?SimpleClass);
            
            r = singleton.SingletonRegistry.getRegistry();
            
            tf1 = r.hasInstance('SimpleClass');
            delete(obj1)
            tf2 = r.hasInstance('SimpleClass');
            
            verifyEqual(self, {tf1 tf2 r.Count}, {true false 0})
        end
        
    end
    
end
