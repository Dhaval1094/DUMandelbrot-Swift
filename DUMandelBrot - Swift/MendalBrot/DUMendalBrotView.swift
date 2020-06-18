//
//  DUMandelBrotView.swift
//  DUMandelBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit
import CoreGraphics

protocol DUMandelBrotViewDelegate {
    func iterationsCompletedWith(count: Int)
    func iterationEquationValues(arrInSideSetEquetions: [String], arrOutSideSetEquetions:[String])
    func pickedCoordinate(complex: Complex)
}

class DUMandelBrotView: UIView {
    
    //MARK: - Variables
    
    var complexPlane = ComplexPlane()
    var pixelValue = 1.0
    var iterationCount = 100 //Iteration count for 1 perticular coordinate
    var colorSet = [UIColor]()
    var delegate: DUMandelBrotViewDelegate?
    var isStartDrawing = false
    var totalIterations = 0
    var arrInSideSetEquetions = [String]()
    var arrOutSideSetEquetions = [String]()
    var isDrawingNeeded = true
    var isPickerMode = false
    var arrRealnComplexCoords = [(CGPoint.zero,Complex())]
    var isColorsInitialized = false
    
    //Mark: - Lifecycle methods
    
    override func draw(_ rect: CGRect) {
        if !isStartDrawing {
            return
        }
        if !isColorsInitialized {
            isColorsInitialized = true
            initializeColors()
        }
        let startTime = Date().timeIntervalSince1970
        drawMandelbrotOnComplexPlane(rect: rect)
        //Drwing completed
        calculateTime(startTime: startTime)
    }
    
    //Mark: - Other Methods
    
    func calculateTime(startTime: Double) {
        let elapsedTime = Date().timeIntervalSince1970 - startTime
        Swift.print("Elapsed time: \(elapsedTime) seconds", terminator: "")
        delegate?.iterationsCompletedWith(count: totalIterations)
        delegate?.iterationEquationValues(arrInSideSetEquetions: arrInSideSetEquetions, arrOutSideSetEquetions: arrOutSideSetEquetions)
    }
    
    func drawMandelbrotOnComplexPlane(rect : CGRect) {
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let startTime = Date().timeIntervalSince1970
        totalIterations = 0
        arrRealnComplexCoords.removeAll()
        for xVal in stride(from: 0, to: width, by: pixelValue) {
            for yVal in stride(from: 0, to: height, by: pixelValue) {
                let complexNum = self.convertViewCoordinatesToComplexCoordinates(x: xVal, y: yVal, rect: rect)
                arrRealnComplexCoords.append((CGPoint.init(x: xVal, y: yVal), complexNum))
                let color = self.implementMandelbrotEquationOn(complexNum: complexNum)
                let path = UIBezierPath(rect: CGRect(x: xVal, y: yVal, width: pixelValue, height: pixelValue))
                color.set()
                path.fill()
                totalIterations += 1
            }
        }
        let elapsedTime = Date().timeIntervalSince1970 - startTime
        print("Calculation time: \(elapsedTime)", terminator: "")
    }
    
    func createMandelBortRectFor(complex: Complex, zoomVal: Double) {
        let zoom = Double(2.0/Double(zoomVal))
        var topLeftPoint = complex
        var bottomRightPoint = complex
        topLeftPoint.real = topLeftPoint.real - zoom
        topLeftPoint.imaginary = topLeftPoint.imaginary - zoom
        bottomRightPoint.real = bottomRightPoint.real + zoom
        bottomRightPoint.imaginary = bottomRightPoint.imaginary + zoom
        
        //Initialize complex plane with zoom level
        self.complexPlane = ComplexPlane(topLeftPoint, bottomRightPoint)
        isPickerMode = false
        self.setNeedsDisplay()
    }
    
    func initializeColors() {
        colorSet.removeAll()
        for i in 0...iterationCount {
            var float: CGFloat {
                return CGFloat(arc4random()) / CGFloat(UInt32.max)
            }
            let r = float
            let g = float
            let b = float
            colorSet.append(UIColor.init(red: r, green: g, blue: b, alpha: 1.0))
        }
    }
    
    //            let hue = CGFloat(abs(sin(Double(i)/30.0)))
    //            let brightness = CGFloat(Double(i)/100.0 + 0.8)
    //            colorSet.append(UIColor(hue: hue, saturation: 1.0, brightness: brightness, alpha: 1.0))
    
    func convertViewCoordinatesToComplexCoordinates(x: Double, y: Double, rect: CGRect) -> Complex {
        
        let topLeft = complexPlane.topLeft
        let bottomRight = complexPlane.bottomRight
        
        let xPlot = x/Double(rect.size.width)
        let yPlot = y/Double(rect.size.height)
        
        let topReal = topLeft.real
        let bottomReal = xPlot * (bottomRight.real - topLeft.real)
        
        let topImaginary = topLeft.imaginary
        let bottomImaginary = yPlot * (bottomRight.imaginary - topLeft.imaginary)
        
        let real = topReal + bottomReal
        let imaginary = topImaginary + bottomImaginary
        
        return Complex(real: real,imaginary: imaginary)
    }
    
    func implementMandelbrotEquationOn(complexNum: Complex) -> UIColor {
        //Mandelbrot Equation
        // Zn+1 = (Zn)^2 + c
        var Zn = Complex()
        let c = complexNum
        for i in 1...iterationCount {
            Zn = Zn*Zn + c
            var absoluteNumber: Double {
                let realSquare = Zn.real*Zn.real
                let imaginarySquare = Zn.imaginary*Zn.imaginary
                let riSquare = realSquare + imaginarySquare
                let modulus = sqrt(riSquare) //Absolute Number
                return modulus
            }
            if absoluteNumber > 2 {
                arrOutSideSetEquetions.append(Zn.description)
                return colorSet[i] //Outside the set
            }
        }
        arrInSideSetEquetions.append(Zn.description)
        //Inside the set
        return UIColor.black
    }
    
}

extension DUMandelBrotView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isPickerMode {
            return
        }
        if let touch = touches.first {
            let position = touch.location(in: self)
            let arrTappedPoints = arrRealnComplexCoords.filter {
                let roundRectVal: CGFloat = 5.0
                let rect = CGRect(x: position.x - roundRectVal, y: position.y - roundRectVal, width: roundRectVal * 2, height: roundRectVal * 2)
                return rect.contains($0.0)
            }
            if let first = arrTappedPoints.first {
                var centeredVal = (CGPoint.zero,Complex())
                if arrTappedPoints.count > 1 {
                    centeredVal = arrTappedPoints[arrTappedPoints.count / 2]
                } else {
                    centeredVal = first
                }
                delegate?.pickedCoordinate(complex: centeredVal.1)
            }
        }
    }
}
