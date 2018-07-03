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
    
    var eventDate: String = ""
    let ref = Database.database().reference(withPath: "events")
    
    var items = [Event]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventsTableViewCell
        
        let eventItem = items[indexPath.row]
        
        cell.titleLabel.text = eventItem.title
        cell.authorLabel.text = items[indexPath.row].speaker
        //cell.dateLabel.text = items[indexPath.row].date
        cell.timeLabel.text = items[indexPath.row].time
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        tableView.backgroundColor = .clear
        
        self.title = eventDate
        
        addEvents()
        ref.observe(.value, with: { snapshot in
          
            var newItems: [Event] = []
            
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    let eventItem = Event(snapshot: snapshot) {
                    
                    
                    if eventItem.date.contains(self.eventDate) {
                       newItems.append(eventItem)
                        
                    }
                    
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
 //   @IBAction func addButtonDidTouch(_ sender: AnyObject) {
    func addEvents(){
        var id = 1
            
        var eventItem = Event(speaker: "James Thomas", title: "Serverless: The Misssing Manual", date: "10 July 2018", time: "10.00", localization: "A1", abstract:"Do serverless cloud platforms leave you with more questions than answers? This session will focus on migrating from traditional applications to serverless cloud platforms. You’ll learn about serving files without a web server, managing application state in a stateless environment, running background processes in ephemeral runtimes and more. These techniques will enable you to build modern applications using serverless platforms. This session is for developers who see the benefits of serverless but are struggling to adjust to a serverless world.")
        var eventItemRef = self.ref.child(String(describing: id))
        eventItemRef.setValue(eventItem.toAnyObject())
        
        id = id + 1
        
        eventItem = Event(speaker: "Alexander Meijers", title: "Extend vizualization of Microsoft Graph to HoloLens applications", date: "10 July 2018", time: "10.30", localization: "A1", abstract:"Think of provisioning information on real-life objects or straw through Cloud data like persons, related contacts, documents and other stuff. This allows you to build rich applications containing information you normally process in a 2D world like your browsers. By extending it to a 3D world, you are able to process the data in a completely different way. Think of creating teams of people within your organization and group them based on specialties, getting a more clear inside view of your site structure in SharePoint or have a 3D model of the Microsoft Graph entities related objects.")
         eventItemRef = self.ref.child(String(describing: id))
        eventItemRef.setValue(eventItem.toAnyObject())
        
        id = id + 1
        
        eventItem = Event(speaker: "Vitaliy Rudnytskiy", title: "The World in your Database: Geospatial Analytics for the rest of us", date: "10 July 2018", time: "11.30", localization: "A1", abstract:"More and more of data is becoming location-aware, introducing the need to combine business data with geographical data. Understanding spatial data and algorithms is becoming a key skill for developers. The world of geospatial data is fascinating and in this session Vitaliy will take you on a journey from a single point in Euclidean geometry to the Earth’s ellipsoid as seen from the database perspective.")
        eventItemRef = self.ref.child(String(describing: id))
        eventItemRef.setValue(eventItem.toAnyObject())
        
        id = id + 1
        
        eventItem = Event(speaker: "Marcin Stachowiak", title: "Where software engineering is going", date: "10 July 2018", time: "12.30", localization: "A1", abstract:"Machine learning is becoming more and more popular. If you have wondered how Artificial Intelligence can support processes and increase the quality of products in Software Engineering - this lecture is for you. Specific examples will be presented, where Artificial Intelligence can assist an architect, developer or tester in his daily work. In addition, we will show how the Capgemini Software Solutions Center in Wrocław adapts the latest trends, ensuring the best quality in delivered products.")
        eventItemRef = self.ref.child(String(describing: id))
        eventItemRef.setValue(eventItem.toAnyObject())
            
        id = id + 1
        
        eventItem = Event(speaker: "Tiffany Jernigan", title: "Dear AWS, Please Run My Containers for Me", date: "11 July 2018", time: "10.00", localization: "B5", abstract:"Think about running a few containers in the cloud. That doesn't sound too bad, right? What about managing an entire fleet? Well, that is definitely much more difficult and can be a lot of work. So we created Amazon Elastic Container Service (ECS), a highly scalable, high-performance container orchestration service that allows you to easily run and scale containerized applications on AWS. However, that was only half of the equation. We then created a new technology, AWS Fargate, to integrate with ECS (and later, Amazon EKS!) to deploy and manage containers without having to manage the underlying infrastructure. In this talk, we will dive into ECS and Fargate and then see them in action running microservices.")
        eventItemRef = self.ref.child(String(describing: id))
        eventItemRef.setValue(eventItem.toAnyObject())
        
        id = id + 1
        
        eventItem = Event(speaker: "Marek Wagner", title: "From chaos to structured service", date: "11 July 2018", time: "11.00", localization: "B5", abstract:"Working with every piece of code delivered by external vendor is always a challenge. How about handover of many, complex solutions which are still evolving and play critical role for your company? We would like to share our experience related to building brand new web development teams, providing support for hundreds of websites used by our company. We will describe major challanges we met , as well as share our tips how to avoid biggest mistakes in building service lines in huge organization.")
        eventItemRef = self.ref.child(String(describing: id))
        eventItemRef.setValue(eventItem.toAnyObject())
        
        id = id + 1
        
        eventItem = Event(speaker: "Monika Januszek", title: "Are your tests useful", date: "11 July 2018", time: "12.00", localization: "B5", abstract:"What good are your tests? What can they bring into your project? Can your tests hurt you and how? What does it take to write a good test? How to do it? And what does it mean that test is \'good\'? In this presentation I will address all those questions basing on my 10 years' experience as a quality specialist. Most projects do not allocate enough time for testing. I have yet to see a project where deadlines do not interfere with quality. However, all is not lost. I will share thoughts and experiences that will help you handle testing in such a way that you bring most value possible under real-life constraints. I will talk about return on investment, test design techniques and when not to write tests. But above all I will demonstrate pragmatic approach to quality.")
        eventItemRef = self.ref.child(String(describing: id))
        eventItemRef.setValue(eventItem.toAnyObject())
            
      
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
            let destinationController = segue.destination as! EventDetailViewController
            
            destinationController.titleValue = items[indexPath.row].title
            destinationController.speakerValue = items[indexPath.row].speaker
            destinationController.dateValue = items[indexPath.row].date
            destinationController.timeValue = items[indexPath.row].time
            destinationController.localizationValue = items[indexPath.row].localization
            destinationController.abstractValue = items[indexPath.row].abstract
 
        }
 
        
    }
 
    

}
extension UILabel {
    var optimalHeight : CGFloat {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
        
}
}
