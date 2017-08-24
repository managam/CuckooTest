// MARK: - Mocks generated from file: CuckooTest/AppDelegate.swift at 2017-08-24 04:48:09 +0000

//
//  AppDelegate.swift
//  CuckooTest
//
//  Created by admin on 8/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Cuckoo
@testable import CuckooTest

import UIKit

class MockAppDelegate: AppDelegate, Cuckoo.Mock {
    typealias MocksType = AppDelegate
    typealias Stubbing = __StubbingProxy_AppDelegate
    typealias Verification = __VerificationProxy_AppDelegate
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: AppDelegate?

    func spy(on victim: AppDelegate) -> Self {
        observed = victim
        return self
    }

    
    // ["name": "window", "accesibility": "", "@type": "InstanceVariable", "type": "UIWindow?", "isReadOnly": false]
     override var window: UIWindow? {
        get {
            return cuckoo_manager.getter("window", original: observed.map { o in return { () -> UIWindow? in o.window }})
        }
        
        set {
            cuckoo_manager.setter("window", value: newValue, original: observed != nil ? { self.observed?.window = $0 } : nil)
        }
        
    }
    

    

    
     override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)  -> Bool {
        
        return cuckoo_manager.call("application(_: UIApplication, didFinishLaunchingWithOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool",
            parameters: (application, launchOptions),
            original: observed.map { o in
                return { (application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool in
                    o.application(application, didFinishLaunchingWithOptions: launchOptions)
                }
            })
        
    }
    
     override func applicationWillResignActive(_ application: UIApplication)  {
        
        return cuckoo_manager.call("applicationWillResignActive(_: UIApplication)",
            parameters: (application),
            original: observed.map { o in
                return { (application: UIApplication) in
                    o.applicationWillResignActive(application)
                }
            })
        
    }
    
     override func applicationDidEnterBackground(_ application: UIApplication)  {
        
        return cuckoo_manager.call("applicationDidEnterBackground(_: UIApplication)",
            parameters: (application),
            original: observed.map { o in
                return { (application: UIApplication) in
                    o.applicationDidEnterBackground(application)
                }
            })
        
    }
    
     override func applicationWillEnterForeground(_ application: UIApplication)  {
        
        return cuckoo_manager.call("applicationWillEnterForeground(_: UIApplication)",
            parameters: (application),
            original: observed.map { o in
                return { (application: UIApplication) in
                    o.applicationWillEnterForeground(application)
                }
            })
        
    }
    
     override func applicationDidBecomeActive(_ application: UIApplication)  {
        
        return cuckoo_manager.call("applicationDidBecomeActive(_: UIApplication)",
            parameters: (application),
            original: observed.map { o in
                return { (application: UIApplication) in
                    o.applicationDidBecomeActive(application)
                }
            })
        
    }
    
     override func applicationWillTerminate(_ application: UIApplication)  {
        
        return cuckoo_manager.call("applicationWillTerminate(_: UIApplication)",
            parameters: (application),
            original: observed.map { o in
                return { (application: UIApplication) in
                    o.applicationWillTerminate(application)
                }
            })
        
    }
    

    struct __StubbingProxy_AppDelegate: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var window: Cuckoo.ToBeStubbedProperty<UIWindow?> {
            return .init(manager: cuckoo_manager, name: "window")
        }
        
        
        func application<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ application: M1, didFinishLaunchingWithOptions launchOptions: M2) -> Cuckoo.StubFunction<(UIApplication, [UIApplicationLaunchOptionsKey: Any]?), Bool> where M1.MatchedType == UIApplication, M2.MatchedType == [UIApplicationLaunchOptionsKey: Any]? {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication, [UIApplicationLaunchOptionsKey: Any]?)>] = [wrap(matchable: application) { $0.0 }, wrap(matchable: launchOptions) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub("application(_: UIApplication, didFinishLaunchingWithOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool", parameterMatchers: matchers))
        }
        
        func applicationWillResignActive<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.StubNoReturnFunction<(UIApplication)> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return .init(stub: cuckoo_manager.createStub("applicationWillResignActive(_: UIApplication)", parameterMatchers: matchers))
        }
        
        func applicationDidEnterBackground<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.StubNoReturnFunction<(UIApplication)> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return .init(stub: cuckoo_manager.createStub("applicationDidEnterBackground(_: UIApplication)", parameterMatchers: matchers))
        }
        
        func applicationWillEnterForeground<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.StubNoReturnFunction<(UIApplication)> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return .init(stub: cuckoo_manager.createStub("applicationWillEnterForeground(_: UIApplication)", parameterMatchers: matchers))
        }
        
        func applicationDidBecomeActive<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.StubNoReturnFunction<(UIApplication)> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return .init(stub: cuckoo_manager.createStub("applicationDidBecomeActive(_: UIApplication)", parameterMatchers: matchers))
        }
        
        func applicationWillTerminate<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.StubNoReturnFunction<(UIApplication)> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return .init(stub: cuckoo_manager.createStub("applicationWillTerminate(_: UIApplication)", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_AppDelegate: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        
        var window: Cuckoo.VerifyProperty<UIWindow?> {
            return .init(manager: cuckoo_manager, name: "window", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        

        
        @discardableResult
        func application<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ application: M1, didFinishLaunchingWithOptions launchOptions: M2) -> Cuckoo.__DoNotUse<Bool> where M1.MatchedType == UIApplication, M2.MatchedType == [UIApplicationLaunchOptionsKey: Any]? {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication, [UIApplicationLaunchOptionsKey: Any]?)>] = [wrap(matchable: application) { $0.0 }, wrap(matchable: launchOptions) { $0.1 }]
            return cuckoo_manager.verify("application(_: UIApplication, didFinishLaunchingWithOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func applicationWillResignActive<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return cuckoo_manager.verify("applicationWillResignActive(_: UIApplication)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func applicationDidEnterBackground<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return cuckoo_manager.verify("applicationDidEnterBackground(_: UIApplication)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func applicationWillEnterForeground<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return cuckoo_manager.verify("applicationWillEnterForeground(_: UIApplication)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func applicationDidBecomeActive<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return cuckoo_manager.verify("applicationDidBecomeActive(_: UIApplication)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func applicationWillTerminate<M1: Cuckoo.Matchable>(_ application: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == UIApplication {
            let matchers: [Cuckoo.ParameterMatcher<(UIApplication)>] = [wrap(matchable: application) { $0 }]
            return cuckoo_manager.verify("applicationWillTerminate(_: UIApplication)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class AppDelegateStub: AppDelegate {
    
     override var window: UIWindow? {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIWindow?).self)
        }
        
        set { }
        
    }
    

    

    
     override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)  -> Bool {
        return DefaultValueRegistry.defaultValue(for: Bool.self)
    }
    
     override func applicationWillResignActive(_ application: UIApplication)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func applicationDidEnterBackground(_ application: UIApplication)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func applicationWillEnterForeground(_ application: UIApplication)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func applicationDidBecomeActive(_ application: UIApplication)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func applicationWillTerminate(_ application: UIApplication)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}




// MARK: - Mocks generated from file: CuckooTest/ViewController.swift at 2017-08-24 04:48:09 +0000

//
//  ViewController.swift
//  CuckooTest
//
//  Created by admin on 8/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Cuckoo
@testable import CuckooTest

import UIKit

class MockViewController: ViewController, Cuckoo.Mock {
    typealias MocksType = ViewController
    typealias Stubbing = __StubbingProxy_ViewController
    typealias Verification = __VerificationProxy_ViewController
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: ViewController?

    func spy(on victim: ViewController) -> Self {
        observed = victim
        return self
    }

    

    

    
     override func viewDidLoad()  {
        
        return cuckoo_manager.call("viewDidLoad()",
            parameters: (),
            original: observed.map { o in
                return { () in
                    o.viewDidLoad()
                }
            })
        
    }
    
     override func didReceiveMemoryWarning()  {
        
        return cuckoo_manager.call("didReceiveMemoryWarning()",
            parameters: (),
            original: observed.map { o in
                return { () in
                    o.didReceiveMemoryWarning()
                }
            })
        
    }
    

    struct __StubbingProxy_ViewController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func viewDidLoad() -> Cuckoo.StubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub("viewDidLoad()", parameterMatchers: matchers))
        }
        
        func didReceiveMemoryWarning() -> Cuckoo.StubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub("didReceiveMemoryWarning()", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_ViewController: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func viewDidLoad() -> Cuckoo.__DoNotUse<Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("viewDidLoad()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func didReceiveMemoryWarning() -> Cuckoo.__DoNotUse<Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("didReceiveMemoryWarning()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class ViewControllerStub: ViewController {
    

    

    
     override func viewDidLoad()  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func didReceiveMemoryWarning()  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}



