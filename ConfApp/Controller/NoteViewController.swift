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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let note = notes[indexPath.row]
        
        let alertController = UIAlertController(title: note.eventTitle, message: "Give new values to update", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Edit", style: .default){(_) in
            
            let title = alertController.textFields?[0].text
            let content = alertController.textFields?[1].text
            
            
            let queryRef = self.ref.queryOrdered(byChild: "eventTitle")
                .queryEqual(toValue: note.eventTitle)
            
            queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    
                     self.updateNote(id: String(userSnap.key), title: title!, content: content!)
                   
                }
            })
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField{ (textField) in textField.text = note.eventTitle }
        
        alertController.addTextField{ (textField) in textField.text = note.content }
        
         alertController.addAction(cancelAction)
        alertController.addAction(updateAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func updateNote(id: String, title: String, content: String){
        
        let note = [
            "id": id,
            "content": content,
            "eventTitle": title,
            "user": Auth.auth().currentUser!.uid
        ]
        
        ref.child(id).setValue(note)
        
    }
    
    func deleteNote(id: String){
        ref.child(id).removeValue()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
             let note = notes[indexPath.row]
            
            let queryRef = self.ref.queryOrdered(byChild: "eventTitle")
                .queryEqual(toValue: note.eventTitle)
            
            queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                   
                     self.deleteNote(id: String(userSnap.key))
                    
                }
            })
        }
        
        
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assignbackground()
          tableView.backgroundColor = .clear
        
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
