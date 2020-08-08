//
//  Containers.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Swinject

enum Containers {
    case viewControllers
    case managers
    
    var container: Container {
        switch self {
        case .viewControllers:
            return type(of: self).viewControllersContainer
        case .managers:
            return type(of: self).managersContainer
        }
    }
    
    private static let viewControllersContainer: Container = {
        let container = Container()
        
        container.register(UIViewController.self, name: CardsModuleConfigurator.tag) { (_, user: AppUser?, flow: FlowController?) in
            let cardConfigurator = CardsModuleConfigurator(user: user)
            let appRouter = managersContainer.resolve(AppRouterProtocol.self, argument: flow)
            cardConfigurator.appRouter = appRouter
            cardConfigurator.firebaseManager = managersContainer.resolve(FirebaseManagerProtocol.self)
            let controller = cardConfigurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: SettingsModuleConfigurator.tag) { (_, flow: FlowController?) in
            let settingsConfigurator = SettingsModuleConfigurator()
            let appRouter = managersContainer.resolve(AppRouterProtocol.self, argument: flow)
            settingsConfigurator.appRouter = appRouter
            let controller = settingsConfigurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: MessagesModuleConfigurator.tag) { (_, flow: FlowController?) in
            let messagesConfigurator = MessagesModuleConfigurator()
            let appRouter = managersContainer.resolve(AppRouterProtocol.self, argument: flow)
            messagesConfigurator.appRouter = appRouter
            let controller = messagesConfigurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: RegistrationModuleConfigurator.tag) { (_, flow: FlowController?) in
            let registrationConfigurator = RegistrationModuleConfigurator()
            registrationConfigurator.firebaseAuthManager = managersContainer.resolve(FirebaseManagerProtocol.self)
            registrationConfigurator.firebaseStrategy = strategiesContainer.resolve(FirebaseSrategiesProtocol.self, name: FirebaseUsersFetcher.tag)
            let appRouter = managersContainer.resolve(AppRouterProtocol.self, argument: flow)
            registrationConfigurator.appRouter = appRouter
            let controller = registrationConfigurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: StartingModuleConfigurator.tag) { (_, flow: FlowController?) in
            let configurator = StartingModuleConfigurator()
            let appRouter = managersContainer.resolve(AppRouterProtocol.self, argument: flow)
            configurator.appRouter = appRouter
            configurator.appleSignInManager = managersContainer.resolve(AppleSignInManagerProtocol.self)
            configurator.googleSignInManager = managersContainer.resolve(GoogleSignInProtocol.self)
            configurator.firebaseStrategy = strategiesContainer.resolve(FirebaseSrategiesProtocol.self, name: FirebaseUsersFetcher.tag)
            let controller = configurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: SideMenuModuleConfigurator.tag) { (_, flow: FlowController?) in
            let configurator = SideMenuModuleConfigurator()
            let appRouter = managersContainer.resolve(AppRouterProtocol.self, argument: flow)
            configurator.appRouter = appRouter
            let controller = configurator.configure()
            return controller
        }

        return container
    }()
    
    private static let strategiesContainer: Container = {
        let container = Container()
        
        container.register(FirebaseSrategiesProtocol.self, name: FirebaseUsersFetcher.tag) { (_)  in
            let strategy = FirebaseUsersFetcher()
            return strategy
        }
        
        return container
    }()
    
    private static let managersContainer: Container = {
        let container = Container()
        
        container.register(UIApplication.self, factory: { _ in UIApplication.shared })
        
        container.register(LaunchManagerProtocol.self) { (_) in
            let launchManager = LaunchManager(factory: viewControllersContainer)
            return launchManager
        }
        
        container.register(AppRouterProtocol.self, factory: { (_, flow: FlowController?) in
            let application = container.resolve(UIApplication.self)
            let appRouter = AppRouter(application: application!, flow: flow, factory: viewControllersContainer)
            return appRouter
        })
        
        container.register(FirebaseManagerProtocol.self) { (_) in
            let firebaseManager = FirebaseManager()
            return firebaseManager
        }
        
        container.register(SecureNonceGeneratorProtocol.self, factory: { (_) in
            let secureNonceGeneratorManager = SecureNonceGeneratorManager()
            return secureNonceGeneratorManager
        })
        
        container.register(AppleSignInManagerProtocol.self, factory: { resolver in
    
            let firebaseAuth = resolver.resolve(FirebaseManagerProtocol.self)
            let nonceGenerator = resolver.resolve(SecureNonceGeneratorProtocol.self)
            let appleSignInManager = AppleSignInManager(nonceGenerator: nonceGenerator!, authManager: firebaseAuth!)
            return appleSignInManager
        })
        
        container.register(GoogleSignInProtocol.self, factory: { resolver in
            let firebaseAuth = resolver.resolve(FirebaseManagerProtocol.self)
            let googleSignInManager = GoogleSignInManager(authManager: firebaseAuth!)
            return googleSignInManager
        })
        
        return container
    }()
}
