//
//  MessagesMessagesPresenter.swift
//  PetMe
//
//  Created by Gaziav on 23/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class MessagesPresenter: MessagesModuleInput, MessagesViewOutput, MessagesInteractorOutput {

    weak var view: MessagesViewInput!
    var interactor: MessagesInteractorInput!
    var router: MessagesRouterInput!

    func viewIsReady() {

    }
}
