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
        
        cell.nameLabel.text = userItem.firstName + " " + userItem.lastName
        cell.jobLabel.text = userItem.job
        cell.companyLabel.text = userItem.company
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        addSpeakers()
        
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
    
    func addSpeakers(){
    var id = 1
        
    var userItem = User(firstName: "James", lastName: "Thomas", company: "IBM", job: "Developer Advocate")
    var userItemRef = self.ref.child(String(describing: id))
    userItemRef.setValue(userItem.toAnyObject())
    
    id = id + 1
        
        userItem = User(firstName: "Alexander", lastName: "Meijers", company: "ETTU", job: "Solutions Architect / HoloLens Evangelist")
        userItemRef = self.ref.child(String(describing: id))
        userItemRef.setValue(userItem.toAnyObject())
        
        id = id + 1
        
        userItem = User(firstName: "Vitaliy", lastName: "Rudnytskiy", company: "SAP", job: "Principal Architect")
        userItemRef = self.ref.child(String(describing: id))
        userItemRef.setValue(userItem.toAnyObject())
        
        id = id + 1
        
        userItem = User(firstName: "Marcin", lastName: "Stachowiak", company: "Capgemini Software Solutions Center", job: "Senior Software Developer")
        userItemRef = self.ref.child(String(describing: id))
        userItemRef.setValue(userItem.toAnyObject())
        
        id = id + 1
        
        userItem = User(firstName: "Tiffany", lastName: "Jernigan", company: "Amazon Web Services", job: "Developer Advocate")
        userItemRef = self.ref.child(String(describing: id))
        userItemRef.setValue(userItem.toAnyObject())
        
        id = id + 1
        
        userItem = User(firstName: "Marek", lastName: "Wagner", company: "GSK IT", job: "Service Manager, Web Dev L3 Support")
        userItemRef = self.ref.child(String(describing: id))
        userItemRef.setValue(userItem.toAnyObject())
        
        id = id + 1
        
        userItem = User(firstName: "Monika", lastName: "Januszek", company: "SAP Polska", job: "Senior Software Engineer")
        userItemRef = self.ref.child(String(describing: id))
        userItemRef.setValue(userItem.toAnyObject())
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destination as! SpeakerDetailViewController
            
            destinationController.firstNameValue = items[indexPath.row].firstName
            destinationController.lastNameValue = items[indexPath.row].lastName
            destinationController.companyValue = items[indexPath.row].company
            destinationController.jobValue = items[indexPath.row].job
            
            
        }
    
    }
    

}
