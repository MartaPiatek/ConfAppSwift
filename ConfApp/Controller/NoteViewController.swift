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
    
    let ref = Database.database().reference(withPath: "notes").child(Auth.auth().currentUser!.uid)
    
    var notes = [Note]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NoteTableViewCell
        
        let noteItem = notes[indexPath.row]
        
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
    

    @IBAction func addNoteButton(_ sender: AnyObject) {
        
        
            let alert = UIAlertController(title: "New note",
                                          message: "Add new note",
                                          preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                guard let textFieldTitle = alert.textFields?[0],
                    let textFieldContent = alert.textFields?[1],
                    let textTitle = textFieldTitle.text,
                 let textContent = textFieldContent.text else {return}
                
                
                let userId = Auth.auth().currentUser!.uid
                let noteItem = Note(user: userId, eventTitle: textTitle, content: textContent)
                
                
                let userItemRef = self.ref.childByAutoId()
                
                userItemRef.setValue(noteItem.toAnyObject())
                // self.tableView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel)
            
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Title"
        }
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Note..."
        }
            
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
