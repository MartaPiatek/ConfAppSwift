//
//  EventDetailViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 10.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase
import FacebookShare
import TwitterKit
import EventKit
import MessageUI

class EventDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {

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
    
    let ref = Database.database().reference(withPath: "observe").child(Auth.auth().currentUser!.uid)
     let refNote = Database.database().reference(withPath: "notes").child(Auth.auth().currentUser!.uid)
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assignbackground()
        
       eventTitle.text = titleValue
        speaker.text = speakerValue
        date.text = dateValue
        time.text = timeValue
        localization.text = localizationValue
        abstract.text = abstractValue
        
        
        
       // eventTitle.lineBreakMode = .byWordWrapping
       /// eventTitle.numberOfLines = 0;
       // eventTitle.sizeToFit()
        
        
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
           
            
            let userItemRef = self.refNote.child(userId)
            
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

      @IBAction func facebookButton(_ sender: AnyObject) {
   // let facebookAction = UIAlertAction(title: "Facebook", style: .default) { (action) in
        
        guard let selectedImage = UIImage(named: "background.jpg") else {
            return
        }
        let photo = Photo(image: selectedImage, userGenerated: false)
        let content = PhotoShareContent(photos: [photo])
        
        let shareDialog = ShareDialog(content: content)
        do {
            try shareDialog.show()
        } catch {
            print(error)
        }
  //  }
}
    
      @IBAction func twitterButton(_ sender: AnyObject) {
        //let twitterAction = UIAlertAction(title: "Twitter", style: .default) { (action) in
            
            guard let selectedImage = UIImage(named: "background.jpg") else {
                return
            }
            
            let composer = TWTRComposer()
            composer.setText("Twitter wiadomosc testowa")
            composer.setImage(selectedImage)
            
            composer.show(from: self, completion: { (result) in
                if(result == .done) {
                    print("Successfully composed Tweet")
                } else {
                    print("Cancelled composing")
                }
            })
     //   }
        
    }
      @IBAction func calendarButton(_ sender: AnyObject) {
        
        let dateCompoments = dateValue.components(separatedBy: " ")
        
        var dateComponent = DateComponents()
        dateComponent.year = Int(dateCompoments[2])
        
        let monthName: String = dateCompoments[1]
        switch monthName {
        case "January":
            dateComponent.month = 1
        case "February":
            dateComponent.month = 2
        case "March":
            dateComponent.month = 3
        case "April":
            dateComponent.month = 4
        case "May":
            dateComponent.month = 5
        case "June":
            dateComponent.month = 6
        case "July":
            dateComponent.month = 7
        case "August":
            dateComponent.month = 8
        case "September":
            dateComponent.month = 9
        case "October":
            dateComponent.month = 10
        case "November":
            dateComponent.month = 11
        case "December":
            dateComponent.month = 12
            
        default:
            print("Error")
        }
        
        
        dateComponent.day = Int(dateCompoments[0])
        
        let userCalendar = Calendar.current
        let dateCalendar = userCalendar.date(from: dateComponent)
        
        
        
        let alertController = UIAlertController(title: "Calendar", message: "What do you want to do?", preferredStyle: .alert)
       
        let calendarAction = UIAlertAction(title: "Add to calendar", style: .default){(_) in
            
            self.addEventToCalendar(title: self.titleValue, description: "Remember or die!", startDate: dateCalendar!, endDate: dateCalendar!)
            self.showToast(message: "Added to calendar")
        }
        
        let observeAction = UIAlertAction(title: "Add to an observing list", style: .default){(_) in
            
            self.addToObserve()
            self.showToast(message: "Added to an observing list")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
       
        
        alertController.addAction(cancelAction)
        alertController.addAction(calendarAction)
         alertController.addAction(observeAction)
        present(alertController, animated: true, completion: nil)
  
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
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
    
    
    func addToObserve(){
            
            let eventItem = Event(speaker:speakerValue, title: titleValue, date: dateValue, time: timeValue, localization: localizationValue, abstract: abstractValue)
        
        let eventItemRef = self.ref.childByAutoId()
            eventItemRef.setValue(eventItem.toAnyObject())
    }
    
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Skia", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 7.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
