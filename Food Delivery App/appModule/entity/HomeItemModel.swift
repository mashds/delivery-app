//
//  ItemModel.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import Foundation
import ObjectMapper

class HomeItemModel: Mappable {
    
    internal var id             : Int?
    internal var title          : String?
    internal var description    : String?
    internal var size           : String?
    internal var priceInUSD     : Double?
    internal var weight         : String?
    internal var imageURL       : String?
    internal var isSpice        : Bool?
    internal var isVegetarian   : Bool?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id              <- map["id"]
        title           <- map["title"]
        description     <- map["description"]
        size            <- map["size"]
        priceInUSD      <- map["priceInUSD"]
        weight          <- map["weight"]
        priceInUSD      <- map["priceInUSD"]
        imageURL        <- map["imageURL"]
        isSpice         <- map["isSpice"]
        isVegetarian    <- map["isVegetarian"]
    }
}
