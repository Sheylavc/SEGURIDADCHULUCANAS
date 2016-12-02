//
//  UsuarioModel.swift
//  CHULUCANAS
//
//  Created by ucweb on 22/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit
import CoreData

class UsuarioModel: NSObject {
    
    class func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func isAvailable()->Bool{
        
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            if searchResults.count != 0{
                
                return true
            }else{
                
                return false
            }
            
            
            //You need to convert to NSManagedObject to use 'for' loops
            /*for trans in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                print("\(trans.value(forKey: "correo"))")
            }*/
            
        } catch {
            print("Error with request: \(error)")
            return false
        }
        
        
        
    }
    
    
    class func createUsuario(dic: AnyObject, pass: String)->Bool {
        
        let json = dic as! [String:AnyObject]
        let usuario = json["product"]
        
        print(usuario!)
        
        let idUsuario = Int(usuario?["usu_id"] as! String)
        let tipo =  Int(usuario?["tip_id"] as! String)
        let email = usuario?["usu_correo"] as! String
        let nombre = usuario?["usu_nom"] as! String
        let apellido = usuario?["usu_ape_pat"] as! String
        let apellidom = usuario?["usu_ape_mat"] as! String
        
       
        let context = getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "Usuario", in: context)
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        transc.setValue(idUsuario, forKey: "usu_id")
        transc.setValue(tipo, forKey: "tip_id")
        transc.setValue(email, forKey: "usu_correo")
        transc.setValue(pass, forKey: "usu_password")
        transc.setValue(nombre, forKey: "usu_nombre")
        transc.setValue(apellido, forKey: "usu_ape_pat")
        transc.setValue(apellidom, forKey: "usu_ape_mat")
        if(tipo == 2){
            let prefs = UserDefaults.standard
            let token = prefs.string(forKey: "tkn")
            transc.setValue(token, forKey: "token")
            
        }
        
        
        do {
            try context.save()
            print("saved!")
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        } catch {
            return false
        }
     
     
     }
    
    class func getUsuario()->Usuario?{
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            //print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            //for trans in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                //print("\(trans.value(forKey: "correo"))")
            //}
            
            return searchResults.first
        } catch {
            print("Error with request: \(error)")
            return nil
        }
    }
    
    class func updatePassword(newPassword: String){
        let context = getContext()
        
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            let usuario  = searchResults.first
            
            usuario?.usu_password = newPassword
            try context.save()
            print("updated!")

            
        } catch {
            
            
        }
    }
    
    class func updateToken(token: String){
        let context = getContext()
        
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            let usuario  = searchResults.first
            
            usuario?.token = token
            try context.save()
            print("updated!")
            
            
        } catch {
            
            
        }
    }

}
