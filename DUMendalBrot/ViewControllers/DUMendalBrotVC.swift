//
//  DUMendalBrotVC.swift
//  DUMendalBrot
//
//  Created by Dhaval Trivedi on 09/06/20.
//  Copyright © 2020 Dhaval Trivedi. All rights reserved.
//

import UIKit

class DUMendalBrotVC: UIViewController, DUMendalBrotViewDelegate {

    @IBOutlet weak var viewEnterZoomLevelPicker: UIView!
    @IBOutlet weak var btnCloseTable: UIButton!
    @IBOutlet weak var txtPickerPixelValue: UITextField!
    @IBOutlet weak var txtZoomLevelPicker: UITextField!
    @IBOutlet weak var viewIndicator: UIView!
    @IBOutlet weak var txtColorCounts: UITextField!
    @IBOutlet weak var txtPixelValue: UITextField!
    @IBOutlet weak var txtZoomValue: UITextField!
    @IBOutlet weak var txtImaginaryNumber: UITextField!
    @IBOutlet weak var txtRealNumber: UITextField!
    @IBOutlet weak var viewSettings: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var mendalBrotView: DUMendalBrotView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var switchShowDetail: UISwitch!
    @IBOutlet weak var lblProcess: UILabel!
    
    var objSet: DUSetProperty!
    var isShowInsideNumbersTable = false
    var arrInSideSetEquetions = [String]()
    var arrOutSideSetEquetions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mendalBrotView.delegate = self
        viewDescription.isHidden = false
        viewEnterZoomLevelPicker.isHidden = true
        tableView.isHidden = true
        btnCloseTable.isHidden = true
        viewSettings.isHidden = true
//        lblProcess.text = "Iterating"
        textView.text = "Iterating"
        viewDescription.layer.borderColor = UIColor.black.cgColor
        viewDescription.layer.borderWidth = 1
        indicatorView.color = UIColor.white
        setDefaultValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func updateView() {
        viewSettings.isHidden = true
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        viewIndicator.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if self.mendalBrotView.isPickerMode {
                self.mendalBrotView.pixelValue = NSString(string: self.txtPickerPixelValue.text ?? "0").doubleValue
            } else {
                self.mendalBrotView.pixelValue = NSString(string: self.txtPixelValue.text ?? "0").doubleValue
            }
            self.mendalBrotView.colorCount = Int(self.txtColorCounts.text ?? "0") ?? 100
            self.mendalBrotView.isStartDrawing = true
            self.lblProcess.text = "Zoom Lavel: " + self.objSet.zoomVal.description
            self.mendalBrotView.createMendalBortRectFor(complex: self.objSet.complex, zoomVal: self.objSet.zoomVal)
        }
    }
    
    func setDefaultValues() {
        txtZoomValue.text = objSet.zoomVal.description
        txtRealNumber.text = objSet.complex.real.description
        txtImaginaryNumber.text = objSet.complex.imaginary.description
        txtPixelValue.text = "6.0"
        txtColorCounts.text = "100"
    }
    
    //MARK: - MendalbrotView Delegate
    
    func iterationsCompletedWith(count: Int) {
        textView.text = "Iterations completed: \(count)"
        indicatorView.stopAnimating()
//        lblProcess.text = "Iteration Completed"
        indicatorView.isHidden = true
        viewIndicator.isHidden = true
    }
    
    func iterationEquationValues(arrInSideSetEquetions: [String], arrOutSideSetEquetions: [String]) {
        self.arrInSideSetEquetions = arrInSideSetEquetions
        self.arrOutSideSetEquetions = arrOutSideSetEquetions
        tableView.reloadData()
    }
    
    func pickedCoordinate(complex: Complex) {
        self.objSet.complex = complex
        self.objSet.zoomVal = NSString(string: txtZoomLevelPicker.text ?? "0").doubleValue
        self.updateView()
    }
    
    //MARK: - Button Actions

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        viewDescription.isHidden = !sender.isOn
        mendalBrotView.isPickerMode = false
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        mendalBrotView.isPickerMode = false
    }

    @IBAction func btnCloseSettingsClicked(_ sender: Any) {
        viewSettings.isHidden = true
        mendalBrotView.isPickerMode = false
    }
    
    @IBAction func btnUpdateSettingsClicked(_ sender: Any) {
        self.objSet.complex.real = NSString(string: txtRealNumber.text ?? "0").doubleValue
        self.objSet.complex.imaginary = NSString(string: txtImaginaryNumber.text ?? "0").doubleValue
        self.objSet.zoomVal = NSString(string: txtZoomValue.text ?? "0").doubleValue
        self.updateView()
        viewSettings.isHidden = true
        mendalBrotView.isPickerMode = false
    }
    
    @IBAction func btnSettingsClicked(_ sender: Any) {
        viewSettings.isHidden = false
        mendalBrotView.isPickerMode = false
    }
    
    @IBAction func btnOutsideClicked(_ sender: Any) {
        viewSettings.isHidden = true
        isShowInsideNumbersTable = false
        tableView.isHidden = false
        btnCloseTable.isHidden = false
        tableView.reloadData()
        mendalBrotView.isPickerMode = false
    }
    
    @IBAction func btnShowInsideClicked(_ sender: Any) {
        viewSettings.isHidden = true
        isShowInsideNumbersTable = true
        tableView.isHidden = false
        btnCloseTable.isHidden = false
        tableView.reloadData()
        mendalBrotView.isPickerMode = false
    }
    
    @IBAction func pickCoordinateClicked(_ sender: Any) {
        txtZoomLevelPicker.text = objSet.zoomVal.description
        txtPixelValue.text = mendalBrotView.pixelValue.description
        mendalBrotView.isPickerMode = true
        viewSettings.isHidden = true
        viewEnterZoomLevelPicker.isHidden = false
    }
    
    @IBAction func btnPickClicked(_ sender: Any) {
        viewEnterZoomLevelPicker.isHidden = true
//        mendalBrotView.updateViewWithPicker(zoomLevel: NSString(string: txtZoomLevelPicker.text ?? "0").doubleValue)
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        tableView.isHidden = true
        sender.isHidden = true
    }
    
    @IBAction func btnChangeColorsClicked(_ sender: Any) {
        mendalBrotView.isColorsInitialized = false
        self.updateView()
    }
    
}

extension DUMendalBrotVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowInsideNumbersTable {
            return arrInSideSetEquetions.count
        }
        return arrOutSideSetEquetions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DUTableViewCellEquations") as! DUTableViewCellEquations
        cell.lblEquation.text = isShowInsideNumbersTable ?  arrInSideSetEquetions[indexPath.row] : arrOutSideSetEquetions[indexPath.row]
        return cell
    }
    
}
