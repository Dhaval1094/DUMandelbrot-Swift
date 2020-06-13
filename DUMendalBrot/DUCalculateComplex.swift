//
//  DUCalculateComplex.swift
//  DUMendalBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import Foundation

func ==(lhs: Complex, rhs: Complex) -> Bool {
    return lhs.real == rhs.real && lhs.imaginary == rhs.imaginary
}

func +(lhs: Complex, rhs: Complex) -> Complex {
    return Complex(real: lhs.real + rhs.real, imaginary: lhs.imaginary + rhs.imaginary)
}

func *(lhs: Complex, rhs: Complex) -> Complex {
    return Complex(real: lhs.real * rhs.real - lhs.imaginary * rhs.imaginary, imaginary: lhs.real * rhs.imaginary + rhs.real * lhs.imaginary)
}

//func -(lhs: Complex, rhs: Complex) -> Complex {
//    return Complex(lhs.real - rhs.real, lhs.imaginary - rhs.imaginary)
//}

//prefix func -(c1: Complex) -> Complex {
//    return Complex( -c1.real, -c1.imaginary)
//}

//func /(lhs: Complex, rhs: Complex) -> Complex {
//    let denom = (rhs.real * rhs.real + rhs.imaginary * rhs.imaginary)
//    return Complex((lhs.real * rhs.real + lhs.imaginary * rhs.imaginary)/denom, (lhs.imaginary * rhs.real - lhs.real * rhs.imaginary)/denom)
//}

//func abs(lhs:Complex) -> Double {
//    return sqrt(lhs.real*lhs.real + lhs.imaginary*lhs.imaginary)
//}
//
//func modulus(lhs:Complex) -> Double {
//    return abs(lhs: lhs)
//}

//func +(lhs: Double, rhs: Complex) -> Complex { // Real plus imaginary
//    return Complex(lhs + rhs.real, rhs.imaginary)
//}

//func -(lhs: Double, rhs: Complex) -> Complex { // Real minus imaginary
//    return Complex(lhs - rhs.real, -rhs.imaginary)
//}

//func *(lhs: Double, rhs: Complex) -> Complex { // Real times imaginary
//    return Complex(lhs * rhs.real, lhs * rhs.imaginary)
//}

//public func ==(lhs: ComplexRect, rhs: ComplexRect) -> Bool {
//    return (lhs.topLeft == rhs.topLeft) && (lhs.bottomRight == rhs.bottomRight)
//}
