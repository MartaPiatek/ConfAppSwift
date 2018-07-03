//
//  GalleryViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 03.07.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let collections = DefaulCollection().photos
    
    
    
    
    var collection: [PhotoItem]?
    
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        //  return the number of sections
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  return the number of items
        return collection!.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCollectionViewCell
        
        if let c = collection {
            cell.imageView?.image = UIImage(named: c[indexPath.row].picture)
            
        }
        
        
        return cell
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        assignbackground()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isTranslucent = true
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        
        collection = collections
        
        self.collectionView.backgroundColor = .clear
    }

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpPhoto") as! PhotoViewController
        
        popOverVC.photoNo = indexPath.row
        
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        
        // popOverVC.imageView.image = UIImage(named: collection![indexPath.row].picture)
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
        /*
         let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
         self.addChildViewController(popOverVC)
         popOverVC.view.frame = self.view.frame
         popOverVC.imageView.image = UIImage(named: collection![indexPath.row].picture)
         self.view.addSubview(popOverVC.view)
         popOverVC.didMove(toParentViewController: self)
         */
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
