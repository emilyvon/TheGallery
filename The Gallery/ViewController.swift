//
//  ViewController.swift
//  The Gallery
//
//  Created by Mengying Feng on 30/04/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var gallery = [Art]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        updateGallery()
        
        if gallery.count == 0 {
            createArt("Pig", productIdentifier: "", imageName: "pig.jpeg", purchased: true)
            createArt("Goose", productIdentifier: "", imageName: "goose.jpeg", purchased: false)
            createArt("Cat", productIdentifier: "", imageName: "cat.jpeg", purchased: false)
            updateGallery()
            self.collectionView.reloadData()
        }
    }
    
    func createArt(title: String, productIdentifier: String, imageName: String, purchased: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        if let entity = NSEntityDescription.entityForName("Art", inManagedObjectContext: context) {
            let art = NSManagedObject(entity: entity, insertIntoManagedObjectContext: context) as! Art
            art.title = title
            art.productIdentifier = productIdentifier
            art.imageName = imageName
            art.purchased = NSNumber(bool: purchased)
        }
        do {
            try context.save()
        } catch{
            print("ERROR")
        }
    }
    
    func updateGallery() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetch = NSFetchRequest(entityName: "Art")
        
        do {
            let artPieces = try context.executeFetchRequest(fetch)
            self.gallery = artPieces as! [Art]
        } catch {
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gallery.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("artCell", forIndexPath: indexPath) as! ArtCollectionViewCell
        
        let art = self.gallery[indexPath.row]
        
        cell.imageView.image = UIImage(named: art.imageName!)

        cell.titleLabel.text = art.title
        
        for subview in cell.imageView.subviews {
            subview.removeFromSuperview()
        }
        
        
        
        if art.purchased!.boolValue {
            cell.purchasedLabel.hidden = true
        } else {
            cell.purchasedLabel.hidden = false
            // blurring
            let blurEffect = UIBlurEffect(style: .Dark)
            let blueView = UIVisualEffectView(effect: blurEffect)
            cell.layoutIfNeeded()
            blueView.frame = cell.imageView.bounds
            cell.imageView.addSubview(blueView)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.size.width - 80, height: self.collectionView.bounds.size.height - 40)
    }
    
}

