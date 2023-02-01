//
//  MapsViewController.swift
//  AppInnovationOneFood
//
//  Created by Eduardo Alexandre on 01/02/23.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // A linha abaixo cria o popup que pergunta se o app pode ter acesso ao gps
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            // A linha abaixo determina a precisão do posicionamento ( verificar consumo de bateria e de dados)
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // A linha abaixo pede a localização
            locationManager.requestLocation()
        }
        
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    
    // Cria um array com as coordenadas da localização, o último indicie é o mais preciso
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Pega o último item do array
        let location = locations.last
        // centralizo as coordenadas da minha localização
        mapView.centerCoordinate = location!.coordinate
        // crio uma região em volta
        let region = mapView.regionThatFits(MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 600.0, longitudinalMeters: 600.0))
        mapView.setRegion(region, animated: false)
    }
    // informa caso aconteca algum erro com o GPS
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}