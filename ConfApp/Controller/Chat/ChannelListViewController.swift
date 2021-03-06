//
//  ChannelListViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 06.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase


class ChannelListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    
    var senderDisplayName: String?
    var newChannelTextField: UITextField?
    private var channels: [Channel] = [] 
    
    
    enum Section: Int {
        case createNewChannelSection = 0
        case currentChannelsSection
    }
    
    
    private lazy var channelRef: DatabaseReference = Database.database().reference().child("channels")
    private var channelRefHandle: DatabaseHandle?
    
    
    private func observeChannels() {
      
        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let name = channelData["name"] as! String?, name.characters.count > 0 { 
                self.channels.append(Channel(id: id, name: name))
                self.tableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

  //    assignbackground()
       tableView.backgroundColor = .white
        
       // self.tableView.delegate = self
        
   //     self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //    self.navigationController?.navigationBar.shadowImage = UIImage()
    //    self.navigationController?.navigationBar.backgroundColor = .clear
     //   self.navigationController?.navigationBar.isTranslucent = true
        
         observeChannels()
    }

    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentSection: Section = Section(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelsSection:
                return channels.count
            }
        } else {
            return 0
        }
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = .clear
        
        if (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelTableViewCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if (indexPath as NSIndexPath).section == Section.currentChannelsSection.rawValue {
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        
      
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Section.currentChannelsSection.rawValue {
            let channel = channels[(indexPath as NSIndexPath).row]
            self.performSegue(withIdentifier: "ShowChannel", sender: channel)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       cell.backgroundColor = .clear
        
    }
    
    
    @IBAction func createChannel(_ sender: AnyObject) {
        if let name = newChannelTextField?.text {
            let newChannelRef = channelRef.childByAutoId()
            let channelItem = [
                "name": name
            ]
            newChannelRef.setValue(channelItem) 
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            let chatVc = segue.destination as! ChatViewController
            
            chatVc.senderDisplayName = Auth.auth().currentUser?.displayName
            chatVc.channel = channel
            chatVc.channelRef = channelRef.child(channel.id)
        }
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
    
}
