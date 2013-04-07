function demo_SingletonManaging()
    % This Example demonstrates of work with singleton instances
    
    
    %% Create first singleton
    
    
    clear all
    
    obj11 = singleton.SingletonFactory.getInstance(?SimpleClass, 10)
    obj12 = singleton.SingletonFactory.getInstance(?SimpleClass)
    
    isEqual = obj11 == obj12
    
    % Create non-singleton instance
    obj = SimpleClass()
    
    isEqual = obj == obj11
    
    
    %% Create second singleton
    obj21 = singleton.SingletonFactory.getInstance(?SimpleProtectedClass)
    obj22 = singleton.SingletonFactory.getInstance(?SimpleProtectedClass, 20)
    
    isEqual = obj21 == obj22
    
    % Create non-singleton of protected class (Error!)
    try
        obj = SimpleProtectedClass()
    catch e
        disp('ooops...')
        disp(e.message)
    end
    
    
    %% Registry
    registry = singleton.SingletonRegistry.getRegistry()
    
    % Get all singleton instances
    instances = registry.getAllInstances()
    
    
    %% Remove and destroy instance
    singleton.SingletonFactory.deleteInstance(?SimpleClass)
    
    obj11
    registry
    instances = registry.getAllInstances()
    
    
    %% Remove registry
    delete(registry)
    
    % See second singleton instance (destroyed)
    registry
    obj22
    
    clear all
end

