//
//  ViewController.swift
//  DUMandelBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit

class DUSelectSetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var arrSet = [DUSetProperty]()
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        arrSet = [
            DUSetProperty(name: Constants.SetNames.e1, image: "e1", complex: Complex(real: -0.7, imaginary: 0.0), zoomVal: 1.4),
            DUSetProperty(name: Constants.SetNames.e2, image: "e2", complex: Complex(real: -0.744, imaginary: 0.12), zoomVal: 200),
            DUSetProperty(name: Constants.SetNames.e3, image: "e3", complex: Complex(real: 0.28,imaginary: 0.485), zoomVal: 800),
            DUSetProperty(name: Constants.SetNames.e4, image: "e4", complex: Complex(real: -1.77,imaginary: 0), zoomVal: 40),
            DUSetProperty(name: Constants.SetNames.e5, image: "e5", complex: Complex(real: -0.1592,imaginary: -1.0338), zoomVal: 160),
            DUSetProperty(name: Constants.SetNames.e6, image: "e6", complex: Complex(real: -1.25865, imaginary: -0.373908), zoomVal: 13200)
        ]
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
        let mendalbrotVC = self.storyboard?.instantiateViewController(identifier: "DUMandelBrotVC") as! DUMandelBrotVC
        mendalbrotVC.objSet = arrSet[indexPath.row]
        self.navigationController?.pushViewController(mendalbrotVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}


