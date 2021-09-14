//
//  HomePresenter.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import Foundation
import UIKit

class HomePresenter: HomeViewToPresenterProtocol {
    
    var view        : HomePresenterToViewProtocol?
    var viewType    : HomeViewType?
    var interactor  : HomePresenterToInteractorProtocol?
    var router      : HomePresenterToRouterProtocol?
    
    func fetchData(category: Category) {
        viewType?.showLoading()
        startFetchingData(category: category)
    }
    
    func startFetchingData(category: Category) {
        switch category {
        case .pizza:
            interactor?.fetchPizza()
            return
        case .pasta:
            interactor?.fetchPasta()
            return
        case .sides:
            interactor?.fetchSides()
            return
        }
    }
    
    func showCartController(navigationController: UINavigationController, cartItems: [HomeItemModel]) {
        router?.pushToCartScreen(navigationConroller: navigationController, cartItems: cartItems)
    }
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func dataFetchedSuccess(dataArray: Array<HomeItemModel>) {
        viewType?.hideLoading()
        view?.showData(data: dataArray)
    }
    
    func dataFetchFailed() {
        viewType?.hideLoading()
        viewType?.displayAlert()
    }
}
