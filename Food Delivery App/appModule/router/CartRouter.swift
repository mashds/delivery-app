//
//  CartRouter.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import Foundation
import UIKit

class CartRouter: CartPresenterToRouterProtocol {
    
    static func createModule() -> CartViewController {
        let view = AppUtils.mainStoryboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        
        let presenter   : CartViewToPresenterProtocol   = CartPresenter()
        let router      : CartPresenterToRouterProtocol = CartRouter()
        
        view.presenter      = presenter
        presenter.router    = router
        
        return view
    }
    
    func pushToNextScreen(navigationConroller navigationController: UINavigationController) {
        // go to next screen
    }
    
    func popToHomeScreen(navigationController: UINavigationController, cartItems: [HomeItemModel]) {
        DispatchQueue.main.async {
            let prevVC = navigationController.getPreviousViewController()  as? HomeViewController
            prevVC?.cartItemsChanged(items: cartItems)
            navigationController.popViewController(animated: true)
        }
    }
}
