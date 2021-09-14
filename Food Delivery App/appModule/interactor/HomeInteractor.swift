//
//  HomeInteractor.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import UIKit
import ObjectMapper

class HomeInteractor: HomePresenterToInteractorProtocol {
    
    var presenter               : HomeInteractorToPresenterProtocol?
    private let networkManager  : NetworkManager
        
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchPizza() {
        _ = networkManager.fetchPizza(completion: { result in
            switch result {
            case let .success(response):
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: response.data, options: []) as AnyObject
                    
                    let pizzaList = Mapper<HomeItemModel>().mapArray(JSONObject: jsonResponse)
                    
                    self.presenter?.dataFetchedSuccess(dataArray: pizzaList ?? [])
                    
                } catch {
                    self.presenter?.dataFetchFailed()
                }
            case let .failure(error):
                print(error)
                self.presenter?.dataFetchFailed()
            }
        })
    }
    
    func fetchPasta() {
        _ = networkManager.fetchPasta(completion: { result in
            switch result {
            case let .success(response):
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: response.data, options: []) as AnyObject
                    
                    let pastaList = Mapper<HomeItemModel>().mapArray(JSONObject: jsonResponse)
                    
                    self.presenter?.dataFetchedSuccess(dataArray: pastaList ?? [])
                    
                } catch {
                    self.presenter?.dataFetchFailed()
                }
            case let .failure(error):
                print(error)
                self.presenter?.dataFetchFailed()
            }
        })
    }
    
    func fetchSides() {
        _ = networkManager.fetchSides(completion: { result in
            switch result {
            case let .success(response):
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: response.data, options: []) as AnyObject
                    
                    let sideList = Mapper<HomeItemModel>().mapArray(JSONObject: jsonResponse)
                    
                    self.presenter?.dataFetchedSuccess(dataArray: sideList ?? [])
                    
                } catch {
                    self.presenter?.dataFetchFailed()
                }
            case let .failure(error):
                print(error)
                self.presenter?.dataFetchFailed()
            }
        })
    }
}
