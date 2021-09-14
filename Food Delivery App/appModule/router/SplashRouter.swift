//
//  SplashRouter.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import Foundation
import UIKit

class SplashRouter:SplashPresenterToRouterProtocol {
    
    static func createModule() -> SplashViewController {
        let view = AppUtils.mainStoryboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        
        let presenter   : SplashViewToPresenterProtocol   = SplashPresenter()
        let router      : SplashPresenterToRouterProtocol = SplashRouter()
        
        view.presenter      = presenter
        presenter.router    = router
        
        return view
    }
    
    func pushToHomeScreen(navigationConroller navigationController: UINavigationController) {
        let homeModule = HomeRouter.createModule()
        DispatchQueue.main.async {
            navigationController.pushViewController(homeModule, animated: true)
        }
    }
    
}
