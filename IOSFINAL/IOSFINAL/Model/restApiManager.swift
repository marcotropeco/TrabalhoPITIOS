//
//  RestApiManager.swift
//  IOSFINAL
//
//  Created by Marco Aurélio Domingos Costa on 11/03/2018.
//  Copyright © 2018 Vitor. All rights reserved.
//

import Foundation
import Alamofire

class RestApiManager {
    
    static let shared = RestApiManager()
    static let baseURL = "https://api.cryptonator.com/api/"
    
    class func load(url : String, onCompletion: @escaping (Ticker?) -> Void) {
        //onCompletion: @escaping ([Ticker]?) -> Void
        
        let url = RestApiManager.baseURL + url
        
        
        Alamofire.request(url).responseJSON { (dataResponse) in
    
            if let data = dataResponse.data , let tickets = try?  JSONDecoder().decode(Ticker.self, from: data){
               // print(tickets.price)
                onCompletion(tickets)
                return
            }
            
            onCompletion(nil)
        }

    }
    
   
}


struct Ticker {
    
    var base : String
    var target : String
    var price : String
    var volume : String
    var change : String
    
    enum CodingKeys: String, CodingKey {
        case ticker
    }
    
    enum UserKeys: String, CodingKey {
        case base, target, price, volume, change
    }
}

extension Ticker: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let user = try values.nestedContainer(keyedBy: UserKeys.self, forKey: .ticker)
        self.base = try user.decode(String.self, forKey: .base)
        self.target = try user.decode(String.self, forKey: .target)
        self.price = try user.decode(String.self, forKey: .price)
        self.volume = try user.decode(String.self, forKey: .volume)
        self.change = try user.decode(String.self, forKey: .change)
    }
}
