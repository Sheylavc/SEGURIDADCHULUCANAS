//
//  DetalleListadoViewController.swift
//  CHULUCANAS
//
//  Created by ucweb on 29/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class DetalleListadoViewController: UIViewController {

    @IBOutlet weak var imgDetalle: UIImageView!
    @IBOutlet weak var nombreDetalle: UILabel!
    @IBOutlet weak var dniDetalle: UILabel!
    @IBOutlet weak var horaDetalle: UILabel!
    @IBOutlet weak var celularDetalle: UILabel!
    @IBOutlet weak var correoDetalle: UILabel!
    @IBOutlet weak var inicialDetalle: UILabel!
    
    @IBOutlet weak var btnPhone: UIView!
    @IBOutlet weak var btnMail: UIView!
    
    
    
    var idAlerta: String!
    var Alerta : Alerta!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SET BACKGROUND IMAGE
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)
        
        setValues()
        
        let tapGesturePhone = UITapGestureRecognizer(target: self, action: #selector(self.tapButtonPhone(_:)))
        btnPhone.addGestureRecognizer(tapGesturePhone)
        
        let tapGestureMail = UITapGestureRecognizer(target: self, action: #selector(self.tapButtonMail(_:)))
        btnMail.addGestureRecognizer(tapGestureMail)
    }
    
    func tapButtonPhone(_ sender: UITapGestureRecognizer) {
        
        let phoneNumber: String = Alerta.usu_celular!
        if phoneNumber.characters.count != 0{
            if #available(iOS 10.0, *) {
                if let url = URL(string: "tel://\(phoneNumber)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }else{
                let aURL = NSURL(string: "tel://\(phoneNumber)")
                //let aURL = NSURL(string: "telprompt://\(phoneNumber)")
                if UIApplication.shared.canOpenURL(aURL as! URL) {
                    UIApplication.shared.openURL(aURL as! URL)
                } else {
                    AlertHelper.notificationAlert(title: "", message: "No se ha podido completar la llamada", viewController: self)
                }
            }
        }else{
            AlertHelper.notificationAlert(title: "", message: "No existe número disponible", viewController: self)
        }
        
        
        
    
        
    }
    func tapButtonMail(_ sender: UITapGestureRecognizer) {
        let mail: String = Alerta.usu_correo!
        if mail.characters.count != 0{
            if #available(iOS 10.0, *) {
                if let url = URL(string: "mailto://\(mail)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }else{
                let aURL = NSURL(string: "mailto://\(mail)")
                //let aURL = NSURL(string: "telprompt://\(phoneNumber)")
                if UIApplication.shared.canOpenURL(aURL as! URL) {
                    UIApplication.shared.openURL(aURL as! URL)
                } else {
                    AlertHelper.notificationAlert(title: "", message: "Debe contar con una bandeja de correo disponible", viewController: self)
                }
            }
        }else{
            AlertHelper.notificationAlert(title: "", message: "No existe número disponible", viewController: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goMapa(_ sender: Any) {
        self.performSegue(withIdentifier: "showMap", sender: idAlerta)
    }
    
    
    func setValues(){
        Alerta = AlertaModel.getAlertasByID(id: idAlerta)
        
        nombreDetalle.text = "\(Alerta.usu_nombre!) \(Alerta.usu_ape_pat!) \(Alerta.usu_ape_mat!)"
        dniDetalle.text = Alerta.usu_dni
        horaDetalle.text = Alerta.ale_fec
        celularDetalle.text = Alerta.usu_celular
        correoDetalle.text = Alerta.usu_correo
        
        let nombre = Alerta.usu_nombre!
        let c = nombre.characters
        let range = c.index(c.startIndex, offsetBy: 0)
        
        inicialDetalle.text = String( nombre[range] )
        
        AlertaModel.updateState(id: String(Alerta.ale_id))
        
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap"
        {
            let nav = segue.destination as! UINavigationController
            let detailViewController = nav.topViewController as! MapaViewController
            detailViewController.idAlerta = sender as? String
        }
    }
    
   

}
