//
//  HomeProtocol.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import Foundation
import UIKit

protocol HomeViewType: AnyObject {
    var presenter: HomeViewToPresenterProtocol? { get set }
    func showLoading()
    func hideLoading()
    func displayAlert()
}


protocol HomeViewToPresenterProtocol: AnyObject {
    
    var view: HomePresenterToViewProtocol? {get set}
    var interactor: HomePresenterToInteractorProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    func fetchData(category: Category)
    func startFetchingData(category: Category)
    func showCartController(navigationController:UINavigationController, cartItems: [HomeItemModel])

}

protocol HomePresenterToViewProtocol: AnyObject {
    func showData(data: Array<HomeItemModel>)
}

protocol HomePresenterToRouterProtocol: AnyObject {
    static func createModule()-> HomeViewController
    func pushToCartScreen(navigationConroller:UINavigationController, cartItems : [HomeItemModel])
}

protocol HomePresenterToInteractorProtocol: AnyObject {
    var presenter: HomeInteractorToPresenterProtocol? {get set}
    func fetchPizza()
    func fetchPasta()
    func fetchSides()
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func dataFetchedSuccess(dataArray:Array<HomeItemModel>)
    func dataFetchFailed()
}
