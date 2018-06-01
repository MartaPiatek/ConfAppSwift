//
//  Icon.swift
//  ConfApp
//
//  Created by Marta Piątek on 15.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import Foundation

struct Icon {
    var name: String = ""
    var price: Double = 0.0
    var isFeatured: Bool = false
    
    
    init(name: String, price: Double, isFeatured: Bool){
        self.name = name
        self.price = price
        self.isFeatured = isFeatured
    }
    
}
