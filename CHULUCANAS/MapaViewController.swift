//
//  MapaViewController.swift
//  CHULUCANAS
//
//  Created by ucweb on 29/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit
import GoogleMaps


class MapaViewController: UIViewController {
    
    var idAlerta : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(idAlerta)
        setUpMap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var backButton: UIBarButtonItem!

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setUpMap(){
        
        let alerta = AlertaModel.getAlertasByID(id: idAlerta!)
        //print((alerta?.ale_longitud)! as String)
        let latitud_s : String = alerta!.ale_latitud! as String
        let latitud : Double = Double( latitud_s )!
        print(latitud)
        let longitud_s : String = alerta!.ale_longitud! as String
        let longitud : Double = Double( longitud_s )!
        //let longitud : Double = Double((alerta?.ale_longitud)! as String)!
        
        print(longitud)
        
        
        let tipo : String = alerta?.ale_tipo?.characters.count == 0 ? "DELINCUENCIA" : (alerta?.ale_tipo)!
        
        let descripcion : String = alerta?.ale_descripcion?.characters.count == 0 ? "No existe descripción" :  (alerta?.ale_descripcion)!
        
        GMSServices.provideAPIKey(DataURL.GlobalVariables.googlemapkey)
        
        let camera = GMSCameraPosition.camera(withLatitude: latitud,
                                                          longitude: longitud, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitud, longitud)
        marker.title = tipo
        marker.snippet = descripcion
        marker.map = mapView
        
    }

}

/*extension MapViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
        }
        
    }
}
*/
