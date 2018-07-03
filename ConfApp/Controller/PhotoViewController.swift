//
//  PhotoViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 26.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
  //  @IBOutlet weak var imageView: UIImageView!

    var imageArray = [UIImage]()
   let collection = DefaulCollection().photos
    
    var photoNo = 0
    @IBOutlet var bigView: UIView!
    
    @IBOutlet weak var smallView: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   self.showAnimate()
       
        smallView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        bigView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        closeButton.addTarget(self, action: #selector(PhotoViewController.closePopUp(_:)), for: .touchUpInside)
        
        mainScrollView.frame = view.frame
        for i in 0..<collection.count {
    let     imageView = UIImageView()
            imageView.image = UIImage(named: collection[i].picture)
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            
            mainScrollView.addSubview(imageView)
            
            closeButton.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 120).isActive = true
           //closeButton.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: -120).isActive = true

            self.view.addSubview(closeButton)
          
           
        }
        
       
      
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
    
   @IBAction func closePopUp(_ sender: Any) {
       
            self.removeAnimate()
    
        
     
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
