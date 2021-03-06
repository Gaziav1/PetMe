//
//  SideMenuSideMenuRouter.swift
//  PetMe
//
//  Created by Gaziav on 04/07/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class SideMenuRouter: SideMenuRouterInput {
    
    var appRouter: AppRouterProtocol!
    
    func performTransition(to destination: RouterDestination) {
        appRouter.changeSideMenuRoot(to: destination)
    }
}
