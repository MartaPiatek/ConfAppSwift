//
//  EventsViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 20.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
      @IBOutlet var tableView: UITableView!
    
    let ref = Database.database().reference(withPath: "events")
    
    var items = [Event]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventsTableViewCell
        
        let eventItem = items[indexPath.row]
     //   cell.textLabel?.text = eventItem.title
     //   cell.detailTextLabel?.text = eventItem.speaker
        
        cell.titleLabel.text = eventItem.title
        cell.authorLabel.text = items[indexPath.row].speaker
        cell.dateLabel.text = items[indexPath.row].date
        cell.timeLabel.text = items[indexPath.row].time
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        ref.observe(.value, with: { snapshot in
            // print(snapshot.value as Any)
            var newItems: [Event] = []
            
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    let eventItem = Event(snapshot: snapshot) {
                    newItems.append(eventItem)
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
            
            
            
            let eventItem = Event(speaker: text,
                title: "To jest tytuł",
                date: "29-08-2018",
                                          time: "10.00",
                                          localization: "a!1")
            
            let eventItemRef = self.ref.child(text)
            
            eventItemRef.setValue(eventItem.toAnyObject())
            //   self.items.append(groceryItem)
            // self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
