//
//  DUComplexNumbers.swift
//  DUMendalBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit
import Foundation

struct Complex: Equatable, CustomStringConvertible {
    
    public var real: Double
    public var imaginary: Double
    public init() {
        self.init(0, 0)
    }
    public init(_ real: Double,_ imaginary:Double) {
        self.real = real
        self.imaginary = imaginary
    }
    
    public var description: String {
        get {
            let r = String(format: "%.2f", real)
            let i = String(format: "%.2f", abs(imaginary))
            var result = ""
            //            let p = -2
            switch (real,imaginary) {
            case _ where imaginary == 0:
                result = "\(r)"
            case _ where real == 0:
                result = "\(i)𝒊"
            case _ where imaginary < 0:
                result = "\(r) - \(i)𝒊"
            default:
                result = "\(r) + \(i)𝒊"
            }
            return result
        }
    }
}
