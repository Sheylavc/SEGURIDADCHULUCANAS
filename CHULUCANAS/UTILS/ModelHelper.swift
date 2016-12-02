//
//  ModelHelper.swift
//  CHULUCANAS
//
//  Created by ucweb on 21/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class ModelHelper: NSObject {

    class func setRootUsuario(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let app = storyboard.instantiateViewController(withIdentifier: "ncAlert")
        UIApplication.shared.keyWindow?.rootViewController = app
    }
    class func setRootPolicia(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let app = storyboard.instantiateViewController(withIdentifier: "ncListado")
        UIApplication.shared.keyWindow?.rootViewController = app
    }
    
    class func loginPnp(email: String?, password: String?, viewcontroller: UIViewController){
        //let ap = UIApplication.shared.delegate as! AppDelegate
        
        if email?.characters.count != 0 && password?.characters.count != 0 {
            
            LoadingIndicatorView.show(viewcontroller.view, loadingText: "Cargando")
            
            let parameters = "correo=\(email!)&contrasenia=\(password!)"
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.getUsuario )! as URL)
            
            
            request.httpMethod = "POST"
            request.httpBody = parameters.data(using: String.Encoding.utf8)
            
            let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
                
                if let _ = responseObject{
                    do{
                        let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                        print(dict)
                        print(dict.count)
                        let status = dict["success"] as! Int
                        
                        
                        DispatchQueue.main.async {
                            LoadingIndicatorView.hide()
                            if(status == 1){
                                let user : [String: AnyObject] = dict["product"] as! [String : AnyObject]
                                let tipo = Int(user["tip_id"] as! String)
                                let estado = Int(user["usu_estado"] as! String)
                                
                               if(tipo == 2 && estado == 1){
                                    if UsuarioModel.createUsuario(dic: dict as AnyObject, pass: password!){
                                        let prefs = UserDefaults.standard
                                        let token = prefs.string(forKey: "tkn")
                                        ModelHelper.saveToken(token: token)
                                        ModelHelper.clearToken()
                                        setRootPolicia()
                                        viewcontroller.performSegue(withIdentifier: "segueListado", sender: nil)
                                        
                                    }
                                
                                }else{
                                    AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "Su cuenta no se encuentra activa. Comuniquese con SEGURIDAD CHULUCANAS.", viewController: viewcontroller)
                                }
                               
                            }else{
                            
                                
                                AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "Los datos ingresados no son correctos. Intente nuevamente.", viewController: viewcontroller)
                            
                            
                            }
                        
                        }
                        
                        
                    }catch{
                        DispatchQueue.main.async {
                            LoadingIndicatorView.hide()
                        }
                        //LoadingHelper().hideLoading()
                    }
                    
                }
            }
            task.resume()
            
        }else{
            
            AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "Ingrese sus datos de usuario correctamente", viewController: viewcontroller)
        }
    }
    class func loginUser(email: String?, password: String?, viewcontroller: UIViewController){
        //let ap = UIApplication.shared.delegate as! AppDelegate
        
        if email?.characters.count != 0 && password?.characters.count != 0 {
            
            LoadingIndicatorView.show(viewcontroller.view, loadingText: "Cargando")
            
            let parameters = "correo=\(email!)&contrasenia=\(password!)"
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.getUsuario )! as URL)
            
            
            request.httpMethod = "POST"
            request.httpBody = parameters.data(using: String.Encoding.utf8)
            
            let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
                
                if let _ = responseObject{
                    do{
                        let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                        print(dict)
                        print(dict.count)
                        let status = dict["success"] as! Int
                        
                        
                        DispatchQueue.main.async {
                            LoadingIndicatorView.hide()
                            if(status == 1){
                                let user : [String: AnyObject] = dict["product"] as! [String : AnyObject]
                                let tipo = Int(user["tip_id"] as! String)
                                let estado = Int(user["usu_estado"] as! String)
                                
                                if(tipo == 1 && estado == 1 ){
                                    
                                    if UsuarioModel.createUsuario(dic: dict as AnyObject, pass: password!){
                                        
                                        
                                        setRootUsuario()
                                        viewcontroller.performSegue(withIdentifier: "segueAlerta", sender: nil)
                                        
                                    }
                                
                                    
                                }else{
                                    AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "Su cuenta no se encuentra activa. Comuniquese con SEGURIDAD CHULUCANAS.", viewController: viewcontroller)
                                }
                                
                            }else{
                                
                                
                                AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "Los datos ingresados no son correctos. Intente nuevamente.", viewController: viewcontroller)
                                
                                
                            }
                            
                        }
                        
                        
                    }catch{
                        DispatchQueue.main.async {
                            LoadingIndicatorView.hide()
                        }
                        //LoadingHelper().hideLoading()
                    }
                    
                }
            }
            task.resume()
            
        }else{
            
            AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "Ingrese sus datos de usuario correctamente", viewController: viewcontroller)
        }
    }
    
    class func updatePassword(password: String?, viewcontroller: UIViewController){
        
        LoadingIndicatorView.show(viewcontroller.view, loadingText: "Cargando")
        let usuario = UsuarioModel.getUsuario()
        let idUsuario =  usuario?.usu_id
        
        let parameters = "usu_id=\(idUsuario!)&usu_contrasenia_e=\(password!)"
        //print(parameters)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.updatePassword )! as URL)
        
        
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
            
            if let _ = responseObject{
                do{
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    print(dic)
                    let message =  dic["message"] as! String
                    let response = dic["success"] as! Int
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                        if response == 1{
                            UsuarioModel.updatePassword(newPassword: password!)
                            AlertHelper.confirmRestore(title: "Actualizar Contraseña", message: "Su contraseña ha sido actualizada correctamente", viewController: viewcontroller)
                            
                            
                        }else{
                            
                            AlertHelper.notificationAlert(title: "Actualizar Contraseña", message: message, viewController: viewcontroller)
                        }

                    
                    }
                    
                    
                }catch{
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                }
                
            }
        }
        task.resume()
       
    }
    
    
    
    
    class func sendConsulta(tipo: String?, consulta: String?, viewcontroller: UIViewController){
        LoadingIndicatorView.show(viewcontroller.view, loadingText: "Cargando")

        let usuario = UsuarioModel.getUsuario()

        let fullname = "\((usuario?.usu_nombre)!) \((usuario?.usu_nombre)!) \((usuario?.usu_ape_mat)!)"
        print(fullname)
        
        let parameters = "nombre=\(fullname)&tipo=\(tipo!)&comentario=\(consulta!)"
        print(parameters)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.sendConsulta )! as URL)
        
        
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
            
            if let _ = responseObject{
                do{
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    
                    
                    let message =  dic["message"] as! String
                    let response = dic["valor"] as! Bool
                    
                    
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                        if response{
                            AlertHelper.confirmRestore(title: "Consulta", message: "Su consulta ha sido enviada correctamente", viewController: viewcontroller)
                        }else{
                            AlertHelper.notificationAlert(title: "Consulta", message: message, viewController: viewcontroller)
                        }
                        
                        
                    }
                    
                    
                }catch{
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                }
                
            }
        }
        task.resume()
        
        
        
        
        
    }
    
    class func sendAlerta(longitud: Double?, latitud: Double?, viewcontroller: UIViewController){
        
        LoadingIndicatorView.show(viewcontroller.view, loadingText: "Cargando")
        let usuario = UsuarioModel.getUsuario()
        let idUsuario =  usuario?.usu_id
        
        let parameters = "id=\(idUsuario!)&longitud=\(longitud!)&latitud=\(latitud!)"
        //print(parameters)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.sendAlerta )! as URL)
        //print(DataURL.GlobalVariables.sendAlerta)
        
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
            
            if let _ = responseObject{
                do{
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    print(dic)
                    //let message =  dic["message"] as! String
                    let response = dic["success"] as! Bool
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                        if response{
                            
                            let prefs = UserDefaults.standard
                            prefs.set(dic["ale_id"], forKey: "key")
                            let key = prefs.string(forKey: "key")
                            print(key!)
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ncDetalle")
                            
                            viewcontroller.present(vc, animated: true)
                        }else{
                           AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "No hemos podido enviar tu Alerta. Intente nuevamente.", viewController: viewcontroller)
                        }
                        
                        
                    }
                    
                    
                }catch{
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                }
                
            }
        }
        task.resume()
        
    }
    
    class func sendDetalle(tipo: String?, descripcion: String?, viewcontroller: UIViewController){
        
        LoadingIndicatorView.show(viewcontroller.view, loadingText: "Cargando")
        
        
        let prefs = UserDefaults.standard
        
        let key = prefs.string(forKey: "key")
        
        
        let parameters = "ale_id=\(key!)&ale_descripcion=\(descripcion!)&ale_tipo=\(tipo!)"
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.updateAlerta )! as URL)
        
        
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
            
            if let _ = responseObject{
                do{
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    print(dic)
                    
                    let response = dic["success"] as! Bool
                    
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                        if response{
                            
                            viewcontroller.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                            
                        }else{
                            AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "No hemos podido enviar el detalle de su alerta. Intente nuevamente.", viewController: viewcontroller)
                        }
                        
                        
                    }
                    
                    
                }catch{
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                }
                
            }
        }
        task.resume()
        
    }
    
    class func restorePassword(email: String?, viewcontroller: UIViewController){
        
        LoadingIndicatorView.show(viewcontroller.view, loadingText: "Cargando")
        
        let parameters = "correo=\(email!)"
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.restorePassword )! as URL)
        
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
            
            if let _ = responseObject{
                do{
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    print(dic)
                    
                    let response = dic["valor"] as! Bool
                    
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                        if response{
                            AlertHelper.confirmRestore(title: "SEGURIDAD CHULUCANAS", message: "Su contraseña fue restablecida, se ha enviado una nueva contraseña a su correo.", viewController: viewcontroller)
                            
                            
                        }else{
                            AlertHelper.notificationAlert(title: "SEGURIDAD CHULUCANAS", message: "No hemos podido enviar el detalle de su alerta. Intente nuevamente.", viewController: viewcontroller)
                        }
                        
                        
                    }
                    
                    
                }catch{
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                }
                
            }
        }
        task.resume()
        
    }
    
    
    class func saveToken(token: String?){
        
        
        let usuario = UsuarioModel.getUsuario()
        let id = usuario?.usu_id
        let parameters = "token=\(token!)&id=\(id!)"
        
        print(parameters)
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.registerToken )! as URL)
        
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
            
            if let _ = responseObject{
                do{
                    try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                }catch{
                   
                }
                
            }
        }
        task.resume()
        
    }
    
    class func getAlertas(){
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.getAlertas )! as URL)
        
        request.httpMethod = "POST"
        //request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
            
            if let _ = responseObject{
                do{
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    //print(dic)
                    
                    
                    let response = dic["success"] as! Int
                    DispatchQueue.main.async {
                        if response == 1{
                            //let data = dic["alertas"] as? AnyObject
                            print(dic["alertas"]!)
                            let _ = AlertaModel.addAlertas(json: dic["alertas"]! )
                        }else{
                            print("no hay alertas disponibles")
                        }
                        
                        
                    }
                    
                    
                }catch{
                    DispatchQueue.main.async {
                        
                    }
                }
                
            }
        }
        task.resume()
        
    }
    
    class func updateWithPushNotification(){
        let prefs = UserDefaults.standard
        prefs.setValue(true, forKey: "notif")
        
    }
    
    class func createToken(token: String){
        let prefs = UserDefaults.standard
        prefs.setValue(token, forKey: "tkn")
        
    }
    
    class func clearToken(){
        let prefs = UserDefaults.standard
        prefs.setValue("", forKey: "tkn")
        
    }
    
    
    
    
}
