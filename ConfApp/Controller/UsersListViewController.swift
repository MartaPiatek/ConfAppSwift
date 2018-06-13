//
//  UsersListViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 30.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class UsersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    
    let ref = Database.database().reference(withPath: "users")
    
    var items = [User]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserTableViewCell
        
        let userItem = items[indexPath.row]
        //   cell.textLabel?.text = eventItem.title
        //   cell.detailTextLabel?.text = eventItem.speaker
        
        cell.firstNameLabel.text = userItem.firstName
        cell.lastNameLabel.text = userItem.lastName
        cell.companyLabel.text = userItem.company
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        ref.observe(.value, with: { snapshot in
            // print(snapshot.value as Any)
            var newItems: [User] = []
            
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    let userItem = User(snapshot: snapshot) {
                    newItems.append(userItem)
                }
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Event Item",
                                      message: "Add an Item",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first,
                let text = textField.text else {return}
            
            
            
            let userItem = User(firstName: text, lastName: "Kowalski", company: "Apple")
            
            let userItemRef = self.ref.child(text)
            
            userItemRef.setValue(userItem.toAnyObject())
           
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destination as! SpeakerDetailViewController
            
            destinationController.firstNameValue = items[indexPath.row].firstName
            destinationController.lastNameValue = items[indexPath.row].lastName
            destinationController.companyValue = items[indexPath.row].company
            
            
        }
    
    }
    

}
