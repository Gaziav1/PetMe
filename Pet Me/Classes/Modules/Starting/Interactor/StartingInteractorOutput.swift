//
//  StartingStartingInteractorOutput.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation
import GoogleSignIn

protocol StartingInteractorOutput: class {
    func signInCompleted(user: AppUser)
    func signInError(error: Error)
}
