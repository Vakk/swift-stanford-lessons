//
//  CalculatorBrain2.swift
//  Calculator
//
//  Created by Valera on 8/29/17.
//  Copyright © 2017 Valera. All rights reserved.
//

import Foundation
struct CalculatorBrain2 {
    
    private let numFormatter = NumberFormatter ()
    
    enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case ternary((Double,Double,Double) -> Double)
    }
    
    private let operations :Dictionary <String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "*" : Operation.binary({$0 * $1}),
        "/" : Operation.binary({$0 / $1}),
        "+" : Operation.binary({$0 + $1}),
        "-" : Operation.binary({$0 - $1}),
        "√" : Operation.unary({sqrt($0)}),
        "cos" : Operation.unary({cos($0)}),
        "sin" : Operation.unary({sin($0)}),
        "(" : Operation.unary({$0}),
        ")" : Operation.unary({$0})
    ]
    
    private var arr : Array = Array<String>()
    
    public mutating func performOperation (_ operation : String) {
        arr.append(String("\(operation)"))
        calculate()
//        if let operationType = operations[operation] {
//            switch operationType {
//            case .constant(let const):
//                
//                break
//            case .binary(f):
//
//            default:
//                break
//            }
//        }
    }
    
    public mutating func setOperand (_ val : Double) {
        let lastValue = arr.last
        if lastValue != nil {
            if numFormatter.number(from: lastValue!)?.doubleValue != nil {
                arr.removeLast()
            }
        }
        
        arr.append(String("\(val)"))
        calculate()
    }
    
    public mutating func clearResult () {
        arr.removeAll()
        calculate()
    }
    
    private mutating func calculate () {
        var isCalculated = false
        
        for i in (0 ..< arr.count).reversed() {
            let value = arr[i]
            if let doubleValue = Double("\(value)") {
                isCalculated = true
                privateResult = doubleValue
                break
            }
        }
        
        if !isCalculated {
            privateResult = 0
        }
    }
    
    private var privateResult : Double?
    
    var result: Double? {
        get {
            return privateResult
        }
    }
 
}
