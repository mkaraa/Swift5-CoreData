//
//  UpdateRecordVC.swift
//  MetehanKARA_HW3
//
//  Created by Metehan kara on 19.05.2020.
//  Copyright © 2020 Metehan kara. All rights reserved.
//

import UIKit

protocol UpdateRecord {
    func updateData(data: (Int, String, String, String, String))
}

class UpdateRecordVC: UIViewController {
    
    // MARK: Variables
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var midtermTF: UITextField!
    @IBOutlet weak var finalTF: UITextField!
    
    var mStudent = [Student]()
    var delegate: UpdateRecord?
    
    var id: Int? = nil
    var name: String? = nil
    var surname: String? = nil
    var midterm: String? = nil
    var final: String? = nil
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // recive data from MainVC for selected user
        if let tn = name, let ts = surname, let tmd = midterm, let tf = final {
            
            nameTF.text! = tn
            surnameTF.text! = ts
            midtermTF.text! = tmd
            finalTF.text! = tf
            
        }
    }
    
    // MARK: Update Student Button Action
    
    @IBAction func updateStudent(_ sender: Any) {
        
        // MARK: Validate textfields
        
        validateTF()
        
    }
    
    // MARK: Validate TextFields (TF)
    
    func validateTF(){
        if nameTF.text!.isEmpty || surnameTF.text!.isEmpty || midtermTF.text!.isEmpty || finalTF.text!.isEmpty {
            showAlert(message: "Please fill all text fields!", vc: self)
        } else {
            delegate?.updateData(data: (id ?? -1, nameTF.text!, surnameTF.text!, midtermTF.text!, finalTF.text!))
            
            // dismiss
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Alert
    
    func showAlert(message: String, vc: UIViewController) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Keyboard
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
        
    }
    
    
}
