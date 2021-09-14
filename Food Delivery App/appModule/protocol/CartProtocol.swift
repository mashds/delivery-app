//
//  CartProtocol.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import Foundation
import UIKit

protocol CartViewToPresenterProtocol: AnyObject {
    var router: CartPresenterToRouterProtocol? {get set}
    func showNextController(navigationController: UINavigationController)
    func goBackToPrevController(navigationController: UINavigationController, cartItems: [HomeItemModel])
}

protocol CartPresenterToRouterProtocol: AnyObject {
    static func createModule()-> CartViewController
    func pushToNextScreen(navigationConroller: UINavigationController)
    func popToHomeScreen(navigationController: UINavigationController, cartItems: [HomeItemModel])
}
