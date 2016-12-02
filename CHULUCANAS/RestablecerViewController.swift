//
//  RestablecerViewController.swift
//  CHULUCANAS
//
//  Created by ucweb on 16/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class RestablecerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SET BACKGROUND IMAGE
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func backbutton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendRestore(_ sender: Any) {
        if (txtEmail.text?.characters.count != 0){
            ModelHelper.restorePassword(email: txtEmail.text, viewcontroller: self)
        }else{
            AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "Debe ingresar su correo electrónico registrado", viewController: self)
        }
    }
        

    //MARK: TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
