//
//  DUSetProperty.swift
//  DUMandelBrot
//
//  Created by Dhaval Trivedi on 14/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit

class DUSetProperty: NSObject {
    var name = ""
    var image = ""
    var complex = Complex()
    var zoomVal = 0.0
    init(name: String, image: String, complex: Complex, zoomVal: Double) {
        self.name = name
        self.image = image
        self.complex = complex
        self.zoomVal = zoomVal
    }
}
