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
        let tl_real = min(c1.real, c2.real)
        let tl_imaginary = max(c1.imaginary, c2.imaginary)
        let br_real = max(c1.real, c2.real)
        let br_imaginary = min(c1.imaginary, c2.imaginary)
        topLeft = Complex(real: tl_real, imaginary: tl_imaginary)
        bottomRight = Complex(real: br_real, imaginary: br_imaginary)
        bottomLeft = Complex(real: tl_real, imaginary: br_imaginary)
        topRight = Complex(real: br_real, imaginary: tl_imaginary)
    }

}

