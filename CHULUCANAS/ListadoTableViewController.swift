//
//  ListadoTableViewController.swift
//  CHULUCANAS
//
//  Created by ucweb on 29/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging


class ListadoTableViewController: UITableViewController {

    private var registrosAlerta: [Alerta]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderArray()
        
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.checkNotification), name: .UIApplicationDidBecomeActive, object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    func checkNotification(){

        let prefs = UserDefaults.standard
        if prefs.bool(forKey: "notif"){
            getAlertasTable()
            prefs.set(false, forKey: "notif")
            
        }
        
        
    }
    
    func orderArray(){
        registrosAlerta = AlertaModel.getAlertas()
        registrosAlerta.sort {(alert1:Alerta, alert2:Alerta) -> Bool in
            alert1.ale_id < alert2.ale_id
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return registrosAlerta?.count == nil ? 0 : registrosAlerta.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listadoCell", for: indexPath) as! ListadoCell
        
        cell.nombreAlerta.text = "\(registrosAlerta[indexPath.row].usu_nombre!) \(registrosAlerta[indexPath.row].usu_ape_pat!) \(registrosAlerta[indexPath.row].usu_ape_mat!)"
        
        let tipo = registrosAlerta[indexPath.row].ale_tipo
        cell.tipoAlerta.text = tipo?.characters.count == 0 ? "NO ESPECIFICA" : registrosAlerta[indexPath.row].ale_tipo
        
        let nombre = registrosAlerta[indexPath.row].usu_nombre!
        let c = nombre.characters
        let range = c.index(c.startIndex, offsetBy: 0)
        
        cell.inicialAlerta.text = String( nombre[range] )
        
        cell.celularAlerta.text = registrosAlerta[indexPath.row].usu_celular
        cell.horaAlerta.text = registrosAlerta[indexPath.row].ale_fec
        
        
        if(registrosAlerta[indexPath.row].ale_estado == "0"){
            //cell.backgroundColor = UIColor.red
            cell.contentView.backgroundColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0)
        }else{
            cell.contentView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let idAlerta : String = String(registrosAlerta[indexPath.row].ale_id)
        
        self.performSegue(withIdentifier: "showDetalle", sender: idAlerta)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetalle"
        {
            let nav = segue.destination as! UINavigationController
            let detailViewController = nav.topViewController as! DetalleListadoViewController
            detailViewController.idAlerta = sender as? String
        }
    }
    
    func getAlertasTable(){
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: DataURL.GlobalVariables.getAlertas )! as URL)
        
        request.httpMethod = "POST"
        //request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {(data, responseObject, error) in
            
            if let _ = responseObject{
                do{
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    print(dic)
                    
                    
                    let response = dic["success"] as! Int
                    DispatchQueue.main.async {
                        if response == 1{
                            //let data = dic["alertas"] as? AnyObject
                            print(dic["alertas"]!)
                            if AlertaModel.addAlertas(json: dic["alertas"]! ) {
                                self.orderArray()
                                self.tableView.reloadData()
                            }
                            
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
   
    

}
