//
//  SearchViewController.swift
//  DraftInfo
//
//  Created by Krishna Kushwaha on 16/09/20.
//  Copyright © 2020 Krishna Kushwaha. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var searchBar: UISearchBar!
       
       @IBOutlet var tableView: UITableView!
//    var countryList = [String]()
    
    var searchedL = [String]()
    
        var cList = ["CT > Brain","CT > Angiography > Cerebral","MRI > Brain","MRI > Screening > Brain","MRI > Breast","MRI > Branchial Plexus","NM > PET CT > Brain"]
    var searching = false
    var fValue = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
          self.tableView.dataSource = self
          self.searchBar.delegate = self

 if let loadedData = UserDefaults.standard.array(forKey: "selectedC") as? [String] {
                print(loadedData)
    fValue.append(contentsOf: loadedData)
    }
        
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)



    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedL.count
        } else {
            return cList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if searching {
            cell.textLabel?.text = searchedL[indexPath.row]
        } else {
            cell.textLabel?.text = cList[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            let selectedC = searchedL[indexPath.row]
            print(selectedC)
            fValue.append(selectedC)
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: searchedL, userInfo: ["name": selectedC])
            UserDefaults.standard.set(fValue, forKey: "selectedC")

        } else {
            let selectedC = cList[indexPath.row]
            print(selectedC)
            fValue.append(selectedC)
            UserDefaults.standard.set(fValue, forKey: "selectedC")

            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: searchedL, userInfo: ["name": selectedC])

        }
        // Close keyboard when you select cell
        
        self.searchBar.searchTextField.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedL = cList.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
               searchBar.text = ""
               tableView.reloadData()
    }
}
