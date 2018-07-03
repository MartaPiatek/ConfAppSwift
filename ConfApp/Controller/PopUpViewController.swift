//
//  PopUpViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 22.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet weak var smallView: UIView!
    @IBOutlet var bigView: UIView!
    var item: PhotoItem?
    

    
    @IBAction func closePopUp(_ sender: Any) {
          self.removeAnimate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
       self.showAnimate()
        
        
        
        smallView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        bigView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.9, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
