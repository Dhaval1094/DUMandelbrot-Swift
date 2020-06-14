//
//  DUComplexRect.swift
//  DUMandelBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit
import Foundation

class ComplexPlane: NSObject {
    
    static func == (lhs: ComplexPlane, rhs: ComplexPlane) -> Bool {
        return true
    }
    
    var topLeft = Complex()
    var bottomRight = Complex()
    var bottomLeft = Complex()
    var topRight = Complex()
    
    override init() {
        super.init()
    }
    
    init(_ c1: Complex, _ c2: Complex) {
        let tlr = min(c1.real, c2.real)
        let tli = max(c1.imaginary, c2.imaginary)
        let brr = max(c1.real, c2.real)
        let bri = min(c1.imaginary, c2.imaginary)
        topLeft = Complex(real: tlr, imaginary: tli)
        bottomRight = Complex(real: brr, imaginary: bri)
        bottomLeft = Complex(real: tlr, imaginary: bri)
        topRight = Complex(real: brr, imaginary: tli)
    }

}
