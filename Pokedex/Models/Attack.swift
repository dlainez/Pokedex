//
//  Attack.swift
//  Pokedex
//
//  Created by CFPAPP on 13/2/16.
//  Copyright © 2016 DLAINEZM. All rights reserved.
//

import UIKit

    class Attack : NSObject {
        
        var name : String
        var power = 0.0
        
        init(name : String) {
            self.name = name
        }
        
        init(name : String, power : Double) {
            self.name = name
            self.power = power
        }
        
    }
