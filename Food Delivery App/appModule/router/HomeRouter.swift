//
//  HomeRouter.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import Foundation
import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    static func createModule() -> HomeViewController {
        
        let view = AppUtils.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let presenter   : HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor  : HomePresenterToInteractorProtocol = HomeInteractor()
        let router      : HomePresenterToRouterProtocol = HomeRouter()
        
        view.presenter          = presenter
        presenter.view          = view
        presenter.router        = router
        presenter.interactor    = interactor
        interactor.presenter    = presenter
        
        return view
    }
    
    func pushToCartScreen(navigationConroller navigationController: UINavigationController, cartItems: [HomeItemModel]) {
        let cartModule = CartRouter.createModule()
        cartModule.cartItems = cartItems
        navigationController.pushViewController(cartModule,animated: true)
    }
    
}
