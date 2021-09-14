//
//  SplashPresenter.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import Foundation
import UIKit

class SplashPresenter:SplashViewToPresenterProtocol {
    
    var router  : SplashPresenterToRouterProtocol?
    
    func showHomeController(navigationController: UINavigationController) {
        router?.pushToHomeScreen(navigationConroller:navigationController)
    }
    
}
