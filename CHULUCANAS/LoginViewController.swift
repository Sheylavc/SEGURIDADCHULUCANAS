//
//  LoginViewController.swift
//  CHULUCANAS
//
//  Created by ucweb on 16/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SET BACKGROUND IMAGE
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: IBACTIONS
    @IBAction func btnLogin(_ sender: Any) {
        
        getUser()
    }
    
    @IBAction func goPNP(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ncLoginPnp")
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    //MARK: UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    //MARK: GENERAL FUNCTION
    func getUser(){
        ModelHelper.loginUser(email: "prueba@hotmail.com", password: "1234" , viewcontroller: self)
        /*if(txtUsuario.text?.characters.count != 0 && txtUsuario.text?.characters.count != 0){
            //ModelHelper.login(email: txtUsuario.text , password: txtPassword.text , viewcontroller: self)
            
            ModelHelper.login(email: "prueba@hotmail.com", password: "1234" , viewcontroller: self)
        }else{
            AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "Todos los campos son requeridos", viewController: self)
        }*/
        
        
    }

}
