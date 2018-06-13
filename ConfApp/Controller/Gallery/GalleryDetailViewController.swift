//
//  GalleryDetailViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 13.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class GalleryDetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var item: PhotoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let i = self.item{
            imageView.image = UIImage(named: i.picture)
        }
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
