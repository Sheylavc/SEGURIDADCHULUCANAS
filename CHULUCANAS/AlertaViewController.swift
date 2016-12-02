//
//  AlertaViewController.swift
//  CHULUCANAS
//
//  Created by ucweb on 28/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit
import CoreLocation

class AlertaViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var window: UIWindow?
    
    
    @IBOutlet weak var txtUbicacion: UILabel!
    private var latitud : Double! = 0
    private var longitud : Double! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        //SET BACKGROUND IMAGE
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
    
    
    //MARK: IBAction methods
    @IBAction func btnConsulta(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ncConsulta")
        
        self.present(vc, animated: true)
        
    }
    
    @IBAction func btnConfiguracion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ncConfiguracion")
        
        self.present(vc, animated: true)
    }
    
    
    @IBAction func btnAlerta(_ sender: Any) {
        
        if ( txtUbicacion.text != "0.0 | 0.0" ){
            ModelHelper.sendAlerta(longitud: longitud!, latitud: latitud!, viewcontroller: self)
        }else{
            AlertHelper.notificationAlert(title: "ALERTA CHULUCANAS", message: "No hemos podido localizar tu ubicación", viewController: self)
            
        }
        
    }
    
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        manager.stopUpdatingLocation()
        latitud = userLocation.coordinate.latitude
        longitud = userLocation.coordinate.longitude
        txtUbicacion.text = "\(latitud!) | \(longitud!)"
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    
    
}
