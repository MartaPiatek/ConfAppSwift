//
//  AgendaViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 10.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class AgendaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let ref = Database.database().reference(withPath: "events")
    
    var items = [Event]()
    var dates = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AgendaTableViewCell
        
        let eventDate = dates[indexPath.row]
        
       cell.dayLabel?.text = "Day \(indexPath.row + 1) "
            cell.dateLabel?.text = eventDate
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        assignbackground()
        
        tableView.backgroundColor = .clear
        
        
       
        self.tabBarController?.tabBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isTranslucent = true
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        
      //  tableView.backgroundView = UIImageView(image: UIImage(named: "background2.png"))
      //  tableView.backgroundView?.alpha = 0.55
        
        ref.observe(.value, with: { snapshot in

            var dates: [String] = []
            
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    let eventItem = Event(snapshot: snapshot) {
                
                    if !dates.contains(eventItem.date) {
                        dates.append(eventItem.date)
                      
                    }
                   
                }
            }
            

            self.dates = dates
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destination as! EventsViewController
            
            destinationController.eventDate = dates[indexPath.row]
        }
    }
    

}
