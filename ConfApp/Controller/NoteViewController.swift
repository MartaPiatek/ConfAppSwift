//
//  NoteViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 11.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class NoteViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    
    let ref = Database.database().reference(withPath: "notes")
    
    var notes = [Note]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NoteTableViewCell
        
        let noteItem = notes[indexPath.row]
        //   cell.textLabel?.text = eventItem.title
        //   cell.detailTextLabel?.text = eventItem.speaker
        
        cell.titleLabel.text = noteItem.eventTitle
        cell.contentLabel.text = noteItem.content
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref.observe(.value, with: { snapshot in
         
            var newItems: [Note] = []
            
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    let noteItem = Note(snapshot: snapshot) {
                    newItems.append(noteItem)
                }
            }
            
            self.notes = newItems
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
