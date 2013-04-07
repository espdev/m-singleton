function runtests()
    % Run unit tests
    
    import matlab.unittest.TestRunner
    import matlab.unittest.TestSuite
    
    runner = TestRunner.withTextOutput();
    suite = TestSuite.fromClass(?TestSingleton);
    
    result = runner.run(suite)
end
