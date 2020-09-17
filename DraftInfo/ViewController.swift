//
//  ViewController.swift
//  DraftInfo
//
//  Created by Krishna Kushwaha on 15/09/20.
//  Copyright © 2020 Krishna Kushwaha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

       
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet var tableView: UITableView!

    var searching = false
    var isSelected = false
    var fValue = [String]()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.reloadData()
        
        searchTxt.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .touchDown)
        searchTxt.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)


        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

        
    }
    @objc func methodOfReceivedNotification(notification: Notification) {

        searchTxt.text = notification.userInfo?["name"] as? String
        isSelected = true
        if let loadedData = UserDefaults.standard.array(forKey: "selectedC") as? [String] {
                       print(loadedData)
           fValue =  loadedData 
           }
        tableView.reloadData()
        
    }


    @objc func textFieldDidChange(_ textField: UITextField) {

        print("comming")
        if textField.text!.isEmpty {
        performSegue(withIdentifier: "search", sender: nil)
        }

    }
    @objc func deleteV() {
      print(index)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return fValue.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newcell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
            newcell.textLabel?.text = ""
        newcell.nmLbl.text = fValue[indexPath.row]
        index = indexPath.row
        newcell.deleteC.tag = indexPath.row
        newcell.deleteC.addTarget(self, action: #selector(deleteV), for: .touchUpInside)
           
        return newcell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSelected{
            return 200
        } else {
        return 0
        }
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
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("tapped")
//        textField.backgroundColor = UIColor.blue
        performSegue(withIdentifier: "search", sender: nil)

    }
}
