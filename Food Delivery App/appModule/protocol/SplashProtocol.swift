//
//  SplashProtocol.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import Foundation
import UIKit

protocol SplashViewToPresenterProtocol: AnyObject {
    var router: SplashPresenterToRouterProtocol? {get set}
    func showHomeController(navigationController:UINavigationController)
}

protocol SplashPresenterToRouterProtocol: AnyObject {
    static func createModule()-> SplashViewController
    func pushToHomeScreen(navigationConroller:UINavigationController)
}
