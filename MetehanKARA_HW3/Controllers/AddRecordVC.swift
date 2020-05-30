//
//  AddRecordVC.swift
//  MetehanKARA_HW3
//
//  Created by Metehan kara on 19.05.2020.
//  Copyright © 2020 Metehan kara. All rights reserved.
//

import UIKit
import CoreData

protocol AddNewRecord {
    func saveNewStudent(data: (String, String, String, String))
}

class AddRecordVC: UIViewController {
    
    // MARK: Variables
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var midtermTF: UITextField!
    @IBOutlet weak var finalTF: UITextField!
    
    var mStudent = [Student]()
    var delegate: AddNewRecord?
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Save Student Button Action Button
    
    @IBAction func SaveStudentActionButton(_ sender: Any) {
        
        // MARK: Validate textfields
        
        validateTF()
        
    }
    
    // MARK: Validate TextFields (TF)
    
    func validateTF(){
        if nameTF.text!.isEmpty || surnameTF.text!.isEmpty || midtermTF.text!.isEmpty || finalTF.text!.isEmpty {
            showAlert(message: "Please fill all text fields!", vc: self)
        } else {
            delegate?.saveNewStudent(data: (nameTF.text!, surnameTF.text!, midtermTF.text!, finalTF.text!))
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: Show Warning Alert
    
    func showAlert(message: String, vc: UIViewController) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Keyboard Removes when touch screen
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
}
