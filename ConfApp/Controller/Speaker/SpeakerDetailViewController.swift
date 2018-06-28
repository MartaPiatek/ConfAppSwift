//
//  SpeakerDetailViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 13.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class SpeakerDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var company: UILabel!
     @IBOutlet weak var job: UILabel!
   
    
    var firstNameValue: String = ""
    var lastNameValue: String = ""
    var companyValue: String = ""
    var jobValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
self.title = firstNameValue + " " + lastNameValue
        assignbackground()
        
        name.text = firstNameValue + " " + lastNameValue
        company.text = companyValue
        job.text = jobValue
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
