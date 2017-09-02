//
//  Tests.swift
//  Calculator
//
//  Created by Valera on 8/29/17.
//  Copyright © 2017 Valera. All rights reserved.
//

import Foundation
class Tests {
    func someMethod(_ int : String) -> Double {
        var method : (_ val : Double) -> Double
        method = {(v : Double) -> Double in
            return v
        }
        
        for _ in 0...10 {
            
        }
        return method(1)
    }
}
