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
    var selectedAddress: Address? = nil
    @IBOutlet weak var addressTextField: UITextField!
    
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
    
    //Mostra o ponto de posicionamento na tela
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        mapView.showsUserLocation = true
        // Metodo abaixo é responsável por ficar fazendo o update da localização
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func tappedShowAddress(_ sender: Any) {
        getPossibleAddressesFromText()
    }
    
    private func getPossibleAddressesFromText() {
        var addresses: [Address] = []
        // Metodo abaixo recebe um texto e vai buscar o resultado
        CLGeocoder().geocodeAddressString(addressTextField.text!) { (placemarks, error) in
            if error == nil {
                for placemark in placemarks! {
                    addresses.append(self.convertToAddress(placemark: placemark))
                }
                self.showAddressesTable(addresses: addresses)
            } else {
                let controller = UIAlertController(title: "Error", message: "Problem trying to fetch addresses from the text.", preferredStyle: UIAlertController.Style.alert)
                self.present(controller, animated: true)
            }
        }
                                          
    }
    
    private func convertToAddress(placemark: CLPlacemark) -> Address {
        return Address(name: placemark.postalAddress!.street, placemark: placemark, postalAddress: placemark.postalAddress!);
    }
    
    private func showAddressesTable(addresses: [Address]) {
        let addressesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddressesTableViewController") as!
            AddressesTableViewController
        addressesVC.addresses = addresses
        addressesVC.selectedAddress = { address in
            self.selectedAddress = address
        }
        self.navigationController?.pushViewController(addressesVC, animated: true)
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
