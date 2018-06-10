//
//  EventDetailViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 10.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
