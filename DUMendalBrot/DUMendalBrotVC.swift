//
//  DUMendalBrotVC.swift
//  DUMendalBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit

class DUMendalBrotVC: UIViewController, DUMendalBrotViewDelegate {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var mendalBrotView: DUMendalBrotView!

    var objSet: SetProperty!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mendalBrotView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.mendalBrotView.isStartDrawing = true
            self.mendalBrotView.setNeedsDisplay()
            self.mendalBrotView.mandelbrotRect = self.newMandelbrotRect()
        }
    }
    
    func newMandelbrotRect() -> ComplexRect{
        var p1 = objSet.complex
        var p2 = objSet.complex
        let zoom = objSet.zoomVal
        p1.real = p1.real - Double(1.0/Double(zoom))
        p1.imaginary = p1.imaginary - Double(1.0/Double(zoom))
        p2.real = p2.real + Double(1.0/Double(zoom))
        p2.imaginary = p2.imaginary + Double(1.0/Double(zoom))
        return ComplexRect(p1, p2)
    }
    
    func iterationCompleted() {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
