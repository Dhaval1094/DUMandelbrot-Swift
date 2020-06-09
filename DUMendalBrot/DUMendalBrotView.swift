//
//  DUMendalBrotView.swift
//  DUMendalBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit
import CoreGraphics

protocol DUMendalBrotViewDelegate {
    func iterationCompleted()
}

class DUMendalBrotView: UIView {

    public var mandelbrotRect = ComplexRect(Complex(-2.1, 1.5), Complex(1.0, -1.5))
    let rectScale = 1
    let blockiness = 0.5 // pick a value from 0.25 to 5.0
    let colorCount = 2000
    var colorSet = [UIColor]()
    var delegate: DUMendalBrotViewDelegate?
    var isStartDrawing = false
    override func draw(_ rect: CGRect) {
        // Drawing code
       // UIBezierPath(rect: rect)
        if !isStartDrawing {
            return
        }
        let startTime = Date().timeIntervalSince1970
        drawMandelbrot(rect: rect)
        let elapsedTime = Date().timeIntervalSince1970 - startTime
        Swift.print("Elapsed time: \(elapsedTime) seconds", terminator: "")
        delegate?.iterationCompleted()
    }

    func drawMandelbrot(rect : CGRect) {
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let startTime = NSDate().timeIntervalSince1970
        initializeColors()
        
        for x in stride(from: 0, to: width, by: blockiness) {
            //        for x in 0.stride(through: width, by: blockiness) {
            for y in stride(from: 0, to: height, by: blockiness) {
                //            for y in 0.stride(through: height, by: blockiness) {
                let cc = viewCoordinatesToComplexCoordinates(x: x, y: y, rect: rect)
                computeMandelbrotPoint(C: cc).set()
                let path = UIBezierPath(rect: CGRect.init(x: x, y: y, width: blockiness, height: blockiness))
                path.fill()
                
            }
        }
        let elapsedTime = NSDate().timeIntervalSince1970 - startTime
        Swift.print("Calculation time: \(elapsedTime)", terminator: "")
    }
    
    func initializeColors() {
        if colorSet.count < 2 {
            colorSet.removeAll()
            for c in 0...colorCount {
                let c_f = CGFloat(c)
                let hue = CGFloat(abs(sin(c_f/30.0)))
                let brightness = CGFloat(c_f/100.0 + 0.8)
                colorSet.append(UIColor(hue: hue, saturation: 1.0, brightness: brightness, alpha: 1.0))
            }
        }
    }
    
    func viewCoordinatesToComplexCoordinates(x: Double, y: Double, rect: CGRect) -> Complex {
        let tl = mandelbrotRect.topLeft
        let br = mandelbrotRect.bottomRight
        let r = tl.real + (x/Double(rect.size.width * CGFloat(rectScale)))*(br.real - tl.real)
        let i = tl.imaginary + (y/Double(rect.size.height * CGFloat(rectScale)))*(br.imaginary - tl.imaginary)
        return Complex(r,i)
    }
    
    func computeMandelbrotPoint(C: Complex) -> UIColor {
        // Calculate whether the point is inside or outside the Mandelbrot set
        // Zn+1 = (Zn)^2 + c -- start with Z0 = 0
        
        var z = Complex()
        for it in 1...colorCount {
            z = z*z + C
            if modulus(lhs: z) > 2 {
                return colorSet[it] // bail as soon as the complex number is too big (you're outside the set & it'll go to infinity)
            }
        }
        // Yay, you're inside the set!
        return UIColor.black
    }
    
}
