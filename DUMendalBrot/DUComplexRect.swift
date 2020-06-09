//
//  DUComplexRect.swift
//  DUMendalBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit
import Foundation

public struct ComplexRect: Equatable, CustomStringConvertible {
    var topLeft: Complex
    var bottomRight: Complex
    var bottomLeft: Complex
    var topRight: Complex
    
    init(_ c1: Complex, _ c2: Complex) {
        let tlr = min(c1.real, c2.real)
        let tli = max(c1.imaginary, c2.imaginary)
        let brr = max(c1.real, c2.real)
        let bri = min(c1.imaginary, c2.imaginary)
        topLeft = Complex(tlr, tli)
        bottomRight = Complex(brr, bri)
        bottomLeft = Complex(tlr, bri)
        topRight = Complex(brr, tli)
    }

    public var description: String {
        return "tl:\(topLeft), br:\(bottomRight), bl:\(bottomLeft), tr:\(topRight)"
    }
}
