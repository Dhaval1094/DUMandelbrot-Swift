//
//  DUComplexNumbers.swift
//  DUMandelBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit
import Foundation

struct Complex: Equatable, CustomStringConvertible {
    
    var real: Double
    var imaginary: Double
    
    init() {
        self.init(real: 0, imaginary: 0)
    }
    
    init(real: Double,imaginary:Double) {
        self.real = real
        self.imaginary = imaginary
    }
    
    static func ==(lhs: Complex, rhs: Complex) -> Bool {
        return lhs.real == rhs.real && lhs.imaginary == rhs.imaginary
    }

    static func +(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real + rhs.real, imaginary: lhs.imaginary + rhs.imaginary)
    }

    static func *(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real * rhs.real - lhs.imaginary * rhs.imaginary, imaginary: lhs.real * rhs.imaginary + rhs.real * lhs.imaginary)
    }
    
    var description: String {
        get {
            let r = String(format: "%.2f", real)
            let i = String(format: "%.2f", abs(imaginary))
            switch (real,imaginary) {
            case _ where imaginary == 0:
                return r
            case _ where real == 0:
                return i + "i"
            case _ where imaginary < 0:
                return r + " - " + i + "i"
            default:
                return r + " + " + i + "i"
            }
        }
    }
}
