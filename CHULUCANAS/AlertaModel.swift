//
//  AlertaModel.swift
//  CHULUCANAS
//
//  Created by ucweb on 29/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit
import CoreData

class AlertaModel: NSObject {

    class func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    class func getAlertas()->[Alerta]?{
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Alerta> = Alerta.fetchRequest()
        
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
            
            return searchResults
        } catch {
            print("Error with request: \(error)")
            return nil
        }
    }
    
    class func getAlertasByID(id: String)->Alerta?{
        //create a fetch request, telling it about the entity
        // Fetching
        let fetchRequest: NSFetchRequest<Alerta> = Alerta.fetchRequest()
        
        // Create Predicate
        let predicate = NSPredicate(format: "ale_id == %@", id)
        
        fetchRequest.predicate = predicate
        
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            //print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as [NSManagedObject] {
            //get the Key Value pairs (although there may be a better way to do that...
                print("\(trans.value(forKey: "ale_latitud"))")
            }
            
            return searchResults.first
        } catch {
            print("Error with request: \(error)")
            return nil
        }
    }
    
    class func getExistAlertasByID(id: String)->Bool{
        //create a fetch request, telling it about the entity
        // Fetching
        let fetchRequest: NSFetchRequest<Alerta> = Alerta.fetchRequest()
        
        // Create Predicate
        let predicate = NSPredicate(format: "ale_id == %@", id)
        
        fetchRequest.predicate = predicate
        
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            //print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            /*for trans in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                print("\(trans.value(forKey: "ale_id"))")
            }*/
            if searchResults.count > 0{
                return false
            }else{
                return true
            }
            
        } catch {
            print("Error with request: \(error)")
            return false
        }
    }
    
    class func createAlerta(dic: AnyObject) {
        
        let ale_id = Int(dic["ale_id"] as! String)
        let ale_descripcion =  dic["ale_descripcion"] as! String
        let ale_tipo = dic["ale_tipo"] as! String
        let ale_fec = dic["ale_fec"] as! String
        let ale_longitud = dic["ale_longitud"] as! String
        let ale_latitud = dic["ale_latitud"] as! String
        let usu_id = Int(dic["usu_id"] as! String)
        let usu_nom = dic["usu_nom"] as! String
        let usu_ape_pat = dic["usu_ape_pat"] as! String
        let usu_ape_mat = dic["usu_ape_mat"] as! String
        let usu_documento = dic["usu_documento"] as! String
        let usu_tel = dic["usu_tel"] as! String
        let usu_correo = dic["usu_correo"] as! String
        
        
        let context = getContext()
        
        let idAlerta : String = dic["ale_id"] as! String
        
        if AlertaModel.getExistAlertasByID(id: idAlerta) {
            //retrieve the entity that we just created
            let entity =  NSEntityDescription.entity(forEntityName: "Alerta", in: context)
            
            let transc = NSManagedObject(entity: entity!, insertInto: context)
            
            //set the entity values
            transc.setValue(ale_id, forKey: "ale_id")
            transc.setValue(ale_descripcion, forKey: "ale_descripcion")
            transc.setValue(ale_tipo, forKey: "ale_tipo")
            transc.setValue(ale_fec, forKey: "ale_fec")
            transc.setValue(ale_longitud, forKey: "ale_longitud")
            transc.setValue(ale_latitud, forKey: "ale_latitud")
            transc.setValue(usu_id, forKey: "usu_id")
            transc.setValue(usu_nom, forKey: "usu_nombre")
            transc.setValue(usu_ape_pat, forKey: "usu_ape_pat")
            transc.setValue(usu_ape_mat, forKey: "usu_ape_mat")
            transc.setValue(usu_documento, forKey: "usu_dni")
            transc.setValue(usu_tel, forKey: "usu_celular")
            transc.setValue(usu_correo, forKey: "usu_correo")
            transc.setValue("0", forKey: "ale_estado")
            
            
            
            do {
                try context.save()
                print("saved alerta!")
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
                
            } catch {
                
            }
            
            
        }
        
        
        
        
    }
    
    class func addAlertas(json: AnyObject)->Bool{
        let alertas = json as![AnyObject]
        print(alertas)
        //let alertaSet = NSMutableSet()
        
        for categoria in alertas {
            //alertaSet.add(AlertaModel.createAlerta(dic: categoria ) )
            AlertaModel.createAlerta(dic: categoria ) 
            
        }
        return true
    }
    
    class func updateState(id: String){
        let context = getContext()
        
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Alerta> = Alerta.fetchRequest()
        
        // Create Predicate
        let predicate = NSPredicate(format: "ale_id == %@", id)
        
        fetchRequest.predicate = predicate
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            let alerta  = searchResults.first
            
            alerta?.ale_estado = "1"
            try context.save()
            print("updated Estado!")
            
            
        } catch {
            
            
        }
    }
    
    class func deleteRecords() -> Void {
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Alerta")
        
        let result = try? moc.fetch(fetchRequest)
        let resultData = result as! [Alerta]
        
        for object in resultData {
            moc.delete(object)
        }
        
        do {
            try moc.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    
}
