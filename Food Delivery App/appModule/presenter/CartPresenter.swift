//
//  CartPresenter.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import Foundation
import UIKit

class CartPresenter: CartViewToPresenterProtocol {
    var router  : CartPresenterToRouterProtocol?

    func showNextController(navigationController: UINavigationController) {
        router?.pushToNextScreen(navigationConroller: navigationController)
    }
    
    func goBackToPrevController(navigationController: UINavigationController, cartItems: [HomeItemModel]) {
        router?.popToHomeScreen(navigationController: navigationController, cartItems: cartItems)
    }
}
