//
//  ConfiguracionViewController.swift
//  CHULUCANAS
//
//  Created by ucweb on 16/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class ConfiguracionViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtNewPassword: UITextField!
    
    @IBOutlet weak var txtNewPassword2: UITextField!
    
    private var statenew1 = true
    private var statenew2 = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    
    //MARK: IBAction Methods
    
    @IBAction func sendPassword(_ sender: Any) {
        
        let password = txtPassword.text!
        let newpassword =  txtNewPassword.text!
        let newpassword2 = txtNewPassword2.text!
        let usuario = UsuarioModel.getUsuario()
        
        
        if password == usuario?.usu_password{
            if(newpassword == newpassword2){
                ModelHelper.updatePassword(password: newpassword, viewcontroller: self)
            }else{
                AlertHelper.notificationAlert(title: "Restablecer Contraseña", message: "Contraseñas no son iguales", viewController: self)
                
            }
            
        }else{
            AlertHelper.notificationAlert(title: "Restablecer Contraseña", message: "Contraseña anterior no coincide", viewController: self)
            
            
        }
        
        
        
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnConfiguracion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ncConfiguracion")
        
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func btnConsulta(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ncConsulta")
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func showPass1(_ sender: Any) {
        if statenew1{
            txtNewPassword.isSecureTextEntry = false
            statenew1 = false
        }else{
            txtNewPassword.isSecureTextEntry = true
            statenew1 = true
        }
        
        
    }
    
    @IBAction func showPass2(_ sender: Any) {
        if statenew2{
            txtNewPassword2.isSecureTextEntry = false
            statenew2 = false
        }else{
            txtNewPassword2.isSecureTextEntry = true
            statenew2 = true
        }
    }
    
    
    
}

