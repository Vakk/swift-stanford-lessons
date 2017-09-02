//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Valera on 8/24/17.
//  Copyright © 2017 Valera. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator : Double?
    
    public var result : Double? {
        get {
            return accumulator
        }
    }
    
    public var operationIsPending :Bool {
        get {
            return pbo != nil
        }
    }
    
    private var actionsPool = Array<String>()
    
    public var description : String {
        get {
            var resultValue : String = String ()
            for action in actionsPool {
                resultValue.append(action)
            }
            if operationIsPending {
                resultValue.append("...")
            }
            return resultValue
        }
    }
    
    private enum Operations {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equal
    }
    
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand : Double
        
        func perform (with operand : Double) -> Double {
            return function(firstOperand, operand)
        }
    }
    
    private var pbo : PendingBinaryOperation?
    
    private let operations :Dictionary<String, Operations> = [
        "π": Operations.constant(Double.pi),
        "e": Operations.constant(M_E),
        "√": Operations.unaryOperation(sqrt),
        "cos": Operations.unaryOperation(cos),
        "sin": Operations.unaryOperation(sin),
        "±": Operations.unaryOperation({-$0}),
        "×": Operations.binaryOperation(*),
        "+": Operations.binaryOperation(+),
        "/": Operations.binaryOperation(/),
        "-": Operations.binaryOperation(-),
        "=": Operations.equal
    ]

    mutating func performOperation (_ symbol: String) {
        actionsPool.append(symbol)
        if let operationType = operations[symbol] {
            switch operationType {
            case .constant(let value):
                accumulator = value
                break
            case .unaryOperation(let f):
                if accumulator != nil {
                    accumulator = f(accumulator!)
                }
                break
            case .binaryOperation(let f):
                if accumulator != nil {
                    if pbo != nil {
                        accumulator = pbo?.perform(with: accumulator!)
                    }
                    pbo = PendingBinaryOperation(function: f, firstOperand: accumulator!)
                }
                break
            case .equal:
                if let currentPbo = pbo {
                    if let currentAccumulator = accumulator {
                        accumulator = currentPbo.perform(with: currentAccumulator)
                    }
                    pbo = nil
                }
                break
            }
        }
    }
    
    mutating func clearValues () {
        actionsPool.removeAll()
        
    }
    
    mutating func setOperand (_ operand: Double) {
        accumulator = operand
        actionsPool.append(forTailingZero(operand))
    }
    
    func forTailingZero(_ temp: Double) -> String{
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
}
