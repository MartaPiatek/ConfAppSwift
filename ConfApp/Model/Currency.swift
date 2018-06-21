//
//  Currency.swift
//  ConfApp
//
//  Created by Marta Piątek on 05.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import Foundation

/*

typealias Currency = [CurrencyElement]

struct CurrencyElement: Codable {
    let table, no, effectiveDate: String
    let rates: [Rate]
}

struct Rate: Codable {
    let currency, code: String
    let mid: Double
}

*/



struct Currency: Codable {
    
    var currency: String
    var code: String
    var mid: Double
 
    enum CodingKeys: String, CodingKey {
        case currency
        case code
        case mid
    }
 
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        currency = try values.decode(String.self, forKey: .currency)
        code = try values.decode(String.self, forKey: .code)
        mid = try values.decode(Double.self, forKey: .mid)
        
    }
    
}

struct CurrencyDataStore: Codable {
    var table: String
    var no : String
    var rates: [Currency]
    
    enum CodingKeys: String, CodingKey {
        case table
        case no
        case rates
    }
    
    init(from decoder: Decoder) throws {
      
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        table = ((try values.decodeIfPresent(String.self, forKey: .table)))!
        no = (try values.decodeIfPresent(String.self, forKey: .no))!
        rates = (try values.decodeIfPresent([Currency].self, forKey: .rates))!
    }
    
}






