//
//  MenuViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 24.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
   
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var newsButton: UIButton!
    @IBOutlet weak var speakersButton: UIButton!
    
    @IBOutlet weak var currenciesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isTranslucent = true
        //self.tabBarController?.tabBar.barTintColor = UIColor(red: 242, green: 78, blue: 134, alpha: 255)
        //self.tabBarController?.tabBar.tintColor = UIColor(red: 242, green: 78, blue: 134, alpha: 1)
        
        
        chatButton.alignTextBelow(spacing: 6.0)
        aboutButton.alignTextBelow(spacing: 6.0)
        noteButton.alignTextBelow(spacing: 6.0)
        newsButton.alignTextBelow(spacing: 6.0)
        speakersButton.alignTextBelow(spacing: 6.0)
        currenciesButton.alignTextBelow(spacing: 6.0)
      
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

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
}
public extension UIButton {
    
    func alignTextBelow(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsetsMake(spacing, -imageSize.width, -(imageSize.height), 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedStringKey.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
        }
    }
    
}
