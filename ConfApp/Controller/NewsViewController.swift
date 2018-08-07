//
//  NewsViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 29.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let ref = Database.database().reference(withPath: "news")
    
    var news = [News]()
    var dates = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsTableViewCell
        
        let newsItem = news[indexPath.row]
        
        cell.titleLabel.text = newsItem.title
        cell.contentLabel.text = newsItem.content
        
        
        return cell
    }
    
    func addNews(){
        let id = 1
        
        let newsItem = News(title: "No news is good news", content: "")
        let newsItemRef = self.ref.child(String(describing: id))
        newsItemRef.setValue(newsItem.toAnyObject())
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        addNews()
        
        tableView.backgroundColor = .clear
        
        
        
        self.tabBarController?.tabBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isTranslucent = true
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        
        ref.observe(.value, with: { snapshot in
            
            var newItems: [News] = []
            
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    let newsItem = News(snapshot: snapshot) {
                    newItems.append(newsItem)
                }
            }
            
            self.news = newItems
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
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destination as! EventsViewController
            
            destinationController.eventDate = dates[indexPath.row]
        }
    }
   */
    
}
