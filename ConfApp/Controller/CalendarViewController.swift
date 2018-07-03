//
//  CalendarViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 28.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class CalendarViewController: UIViewController ,  UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let ref = Database.database().reference(withPath: "observe").child(Auth.auth().currentUser!.uid)
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        assignbackground()
        tableView.backgroundColor = .clear
        
        ref.observe(.value, with: { snapshot in
            
            var newItems: [Event] = []
            
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    let eventItem = Event(snapshot: snapshot) {
                    newItems.append(eventItem)
                }
            }
            
            self.events = newItems
            self.tableView.reloadData()
        })
        
        
    }
  /*  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let event = events[indexPath.row]
            
            let queryRef = self.ref.queryOrdered(byChild: "title")
                .queryEqual(toValue: event.title)
            
            queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    
                    self.deleteEvent(id: String(userSnap.key))
                    
                }
            })
        }
        
        
        
        tableView.reloadData()
    }
    */
    func deleteEvent(id: String){
        ref.child(id).removeValue()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ObserveEventTableViewCell
    
    let eventItem = events[indexPath.row]
    
    cell.titleLabel.text = eventItem.title
    cell.dateLabel.text = eventItem.date
    cell.timeLabel.text = eventItem.time
        
    
    
    return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, completionHandler) in
                
                let event = self.events[indexPath.row]
                
                let queryRef = self.ref.queryOrdered(byChild: "title")
                    .queryEqual(toValue: event.title)
                
                queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    for snap in snapshot.children {
                        let userSnap = snap as! DataSnapshot
                        
                        self.deleteEvent(id: String(userSnap.key))
                        
                    }
            })
            
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 242.0/255, green: 78.0/255, blue: 134.0/255, alpha: 1.0)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfiguration
    }
    
    func assignbackground(){
        let background = UIImage(named: "background2")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = 0.55
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
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
