//
//  NetworkManager.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-11.
//

import Foundation
import Moya

class NetworkManager {
   
    let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func fetchPizza(completion: @escaping Moya.Completion) -> Cancellable {
        return self.provider.request(API.getPizza, completion: completion)
    }
    
    func fetchPasta(completion: @escaping Moya.Completion) -> Cancellable {
        return self.provider.request(API.getPasta, completion: completion)
    }
    
    func fetchSides(completion: @escaping Moya.Completion) -> Cancellable {
        return self.provider.request(API.getSides, completion: completion)
    }
}
