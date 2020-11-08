//
//  RegistrationRegistrationInteractor.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Moya
import RxSwift

class RegistrationInteractor {
    
    private let disposeBag = DisposeBag()
    
    weak var output: RegistrationInteractorOutput!
    var firebaseStrategy: FirebaseSrategiesProtocol!
    var firebaseAuthManager: AuthManager!
    var provider: MoyaProvider<YoormiTarget>!
}

//MARK: - RegistrationInteractorInput
extension RegistrationInteractor: RegistrationInteractorInput {
    
    func authorizateUser(email: String, password: String) {
        provider
            .requestModel(.signIn(email: email, password: password), User.self)
            .subscribe({ response in
                switch response {
                case .next(let user):
                    print(user)
                case .error(let error as ProviderError):
                    print(error.message)
                default: ()
                }
            }).disposed(by: disposeBag)
    }
    
    
    func signInUser(email: String, password: String) {
        provider
            .requestModel(.signIn(email: email, password: password), User.self)
            .subscribe({ response in
                switch response {
                case .next(let user):
                    print(user)
                case .error(let error as ProviderError):
                    print(error.message)
                default: ()
                }
            }).disposed(by: disposeBag)
    }
    
    
    func authorizateUser(throughPhone phone: String) {
        provider
            .requestModel(.phoneSignUp(phone: phone), Phone.self)
            .subscribe({ [weak self] response in
                switch response {
                case .next(let phone):
                    self?.output.phoneWillRecieveCode()
                case .error(let error as ProviderError):
                    self?.output.phoneWillNotRecieveCode()
                default: ()
                }
            }).disposed(by: disposeBag)
    }
}
