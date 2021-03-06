//
//  AdoptionAdoptionRouter.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class AdoptionRouter: AdoptionRouterInput {

    var appRouter: AppRouterProtocol!

    func presentSideMenu() {
        appRouter.openSideMenu()
    }
    
    func openDetailAdoption() {
        appRouter.performTransitionTo(to: .adoptionDetail)
    }
}
