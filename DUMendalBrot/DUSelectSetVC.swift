//
//  ViewController.swift
//  DUMendalBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit

class DUSelectSetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var arrSet = [
        SetProperty(name: Constants.SetNames.fullSet, image: "FullSet", complex: Complex(-0.75, 0.0), zoomVal: 0.7),
        SetProperty(name: Constants.SetNames.seaHorseValley, image: "Seahore", complex: Complex(-0.744, 0.12), zoomVal: 100),
        SetProperty(name: Constants.SetNames.elephantValley, image: "Elephant", complex: Complex(0.28,0.485), zoomVal: 200),
        SetProperty(name: Constants.SetNames.littleMandlebrot, image: "LittleMendalbrot", complex: Complex(-1.77,0), zoomVal: 20),
        SetProperty(name: Constants.SetNames.anotherMendalbrot, image: "JustAnother", complex: Complex(-0.1592,-1.0338), zoomVal: 80),
        SetProperty(name: Constants.SetNames.justSomeSpot, image: "JustSomeSpot", complex: Complex(-1.25865, -0.373908), zoomVal: 6600)
    ]
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - Other methods
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DUSelectSetCell") as! DUSelectSetCell
        cell.lblName.text = arrSet[indexPath.row].name
        cell.imgView.image = UIImage(named: arrSet[indexPath.row].image)
        return cell
    }
    
    //MARK: - Table View Delegates
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mendalbrotVC = self.storyboard?.instantiateViewController(identifier: "DUMendalBrotVC") as! DUMendalBrotVC
        mendalbrotVC.objSet = arrSet[indexPath.row]
        self.navigationController?.pushViewController(mendalbrotVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.width / 1.5
    }
    
}

class SetProperty {
    
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
