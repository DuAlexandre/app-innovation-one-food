//
//  AddressesTableViewController.swift
//  AppInnovationOneFood
//
//  Created by Eduardo Alexandre on 01/02/23.
//

import UIKit

class AddressesTableViewController: UITableViewController {

    var addresses: [Address] = []
    
    var selectedAddress: ((Address) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath)
        var address = cell.defaultContentConfiguration()
        address.text = addresses[indexPath.row].name
        cell.contentConfiguration = address
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addresses[indexPath.row]
        selectedAddress!(address)
        self.navigationController?.popViewController(animated: true)
    }

}
