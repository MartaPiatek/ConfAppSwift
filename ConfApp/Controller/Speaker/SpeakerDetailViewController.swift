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
   
    
    var firstNameValue: String = ""
    var lastNameValue: String = ""
    var companyValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = firstNameValue + " " + lastNameValue
        company.text = companyValue
       
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
