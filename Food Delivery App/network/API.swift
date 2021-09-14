//
//  API.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-11.
//

import Moya

enum API {
    case getPizza
    case getPasta
    case getSides
}

extension API: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://mocki.io/v1") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .getPizza:
            return "/e6bd1cac-d2f5-4b26-9caf-aa12011dff52"
        case .getPasta:
            return "/16afacb5-6238-42ad-9ae6-ac294b2ecc99"
        case .getSides:
            return "/401f1854-566d-40a1-a460-d75d5483d144"
        }
    }

    var method: Method {
        switch self {
        case .getPizza, .getPasta, .getSides:
            return .get
        }
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

}


