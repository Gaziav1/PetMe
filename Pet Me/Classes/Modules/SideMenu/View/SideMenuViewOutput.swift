//
//  SideMenuSideMenuViewOutput.swift
//  PetMe
//
//  Created by Gaziav on 04/07/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol SideMenuViewOutput {

    func giveData() -> [SideMenuItems]
    func viewIsReady()
    func didSelectRow(at index: Int)
}
