//
//  GalleryCollectionViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 13.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController {

    
     let collections = DefaulCollection().photos
    
   
  
    
    var collection: [PhotoItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       assignbackground()
        
     //   self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
      //  self.navigationController?.navigationBar.shadowImage = UIImage()
      //  self.navigationController?.navigationBar.backgroundColor = .clear
     //   self.navigationController?.navigationBar.isTranslucent = true
        
        
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isTranslucent = true
        
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

       self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
       
        collection = collections
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
      
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpPhoto") as! PhotoViewController
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
        if let destinationViewController = segue.destination as?  PopUpViewController {// GalleryDetailViewController{
            if let cell = sender as? UICollectionViewCell {
                if let indexPath = collectionView?.indexPath(for: cell) {
                    destinationViewController.item = collection![indexPath.row]
                    
                    
                }
            }
        }
       
    }
    

    */
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //  return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  return the number of items
        return collection!.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCollectionViewCell
        
        if let c = collection {
            cell.imageView.image = UIImage(named: c[indexPath.row].picture)
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
