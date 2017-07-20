//
//  ViewController.swift
//  PinterestLayout
//
//  Created by Phung Van Hai on 2/24/17.
//  Copyright © 2017 Phung Van Hai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    let itemsPerRow = 2
    let sectionInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.register(UINib(nibName:"MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsPerRow
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return self.imageList.count / self.itemsPerRow
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        myCell.mImageView.image = UIImage(named: imageList[indexPath.row * 2 + indexPath.section])
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = self.sectionInsets.left * CGFloat(self.itemsPerRow + 1)
        let availableWidth = self.collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        let boundingRect =  CGRect(x: 0, y: 0, width: widthPerItem, height: CGFloat.greatestFiniteMagnitude);
        let rect = AVMakeRect(aspectRatio: (UIImage(named: imageList[indexPath.row * 2 + indexPath.section])?.size)!, insideRect: boundingRect);
        
        return CGSize(width: widthPerItem, height: rect.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

