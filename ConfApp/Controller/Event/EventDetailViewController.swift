//
//  EventDetailViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 10.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class EventDetailViewController: UIViewController {

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var speaker: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var localization: UILabel!
    @IBOutlet weak var abstract: UITextView!
    
    var titleValue: String = ""
    var speakerValue: String = ""
    var dateValue: String = ""
    var timeValue: String = ""
    var localizationValue: String = ""
    var abstractValue: String = ""
    
    let ref = Database.database().reference(withPath: "notes")
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       eventTitle.text = titleValue
        speaker.text = speakerValue
        date.text = dateValue
        time.text = timeValue
        localization.text = localizationValue
        abstract.text = abstractValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNoteButton(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Note Item",
                                      message: "Add an Item",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first,
                let text = textField.text else {return}
            
            
            let userId = Auth.auth().currentUser!.uid
            let noteItem = Note(user: userId, eventTitle: self.titleValue, content: text)
           
            
            let userItemRef = self.ref.child(userId)
            
            userItemRef.setValue(noteItem.toAnyObject())
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