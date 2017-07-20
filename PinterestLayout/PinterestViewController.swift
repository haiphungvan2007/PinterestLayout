//
//  PinterestViewController.swift
//  PinterestLayout
//
//  Created by Phung Van Hai on 2/25/17.
//  Copyright © 2017 Phung Van Hai. All rights reserved.
//

import UIKit
import AVFoundation

protocol PinterestLayoutDelegate {
    //Method to ask the delegate for the height of the image
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath) -> CGFloat
    
    func getNumberOfColumn() -> Int
}


class PinterestViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PinterestLayoutDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    let itemsPerRow = 2
    let sectionInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let layout = self.collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        self.collectionView.register(UINib(nibName:"MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Chỉ ra số cell sẽ có trong CollectionView (quy tắc này do code trong phần layout sử dụng hàm này để lấy ra số cell trong collection view)
        return self.imageList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        myCell.mImageView.image = UIImage(named: imageList[indexPath.item])
        return myCell
    }
    
    
    
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath) -> CGFloat
    {
        let paddingSpace = self.sectionInsets.left * CGFloat(self.itemsPerRow + 1)
        let availableWidth = self.collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        let boundingRect =  CGRect(x: 0, y: 0, width: widthPerItem, height: CGFloat.greatestFiniteMagnitude);
        let rect = AVMakeRect(aspectRatio: (UIImage(named: imageList[indexPath.item])?.size)!, insideRect: boundingRect);
        return rect.height
    }
    
    func getNumberOfColumn() -> Int {
        return self.itemsPerRow
    }
}
