//
//  SplashViewController.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import UIKit

class SplashViewController: UIViewController {
    
    var presenter:   SplashViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redirectToHome()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = true
        }
        super.viewWillAppear(animated)
    }
}

extension SplashViewController {
    func redirectToHome() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.presenter?.showHomeController(navigationController: self.navigationController!)
        }
    }
}
