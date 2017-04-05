//
//  DetailAdapter.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

class DetailAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var item : Movie!
    
    var collectionView : UICollectionView!
    
    
    lazy var ratingCell : UINib = {
       let nib = UINib(nibName: "DetailRatingTitleCell", bundle: Bundle.main)
       return nib
    }()
    
    
    lazy var detailCell : UINib = {
        let nib = UINib(nibName: "DetailTextCell", bundle: Bundle.main)
        return nib
    }()
    
    lazy var headerNib : UINib = {
        let nib = UINib(nibName: "DetailHeaderCell", bundle: Bundle.main)
        return nib
    }()
    
    func initzialized(item : Movie) {
        self.item = item
        
        collectionView.register(ratingCell, forCellWithReuseIdentifier: "ratingCell")
        collectionView.register(detailCell, forCellWithReuseIdentifier: "detailCell")
        //
        collectionView.register(headerNib, forSupplementaryViewOfKind: IOStickyHeaderParallaxHeader, withReuseIdentifier: "header")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //
        if let layout: IOStickyHeaderFlowLayout = self.collectionView.collectionViewLayout as? IOStickyHeaderFlowLayout {
            let width = collectionView.bounds.size.width            
            layout.parallaxHeaderReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 400)
            layout.parallaxHeaderMinimumReferenceSize = CGSize(width: width, height: 0)
            layout.itemSize = CGSize(width: width, height: 200)
            //
            layout.parallaxHeaderAlwaysOnTop = true
            layout.disableStickyHeaders = true
            self.collectionView.collectionViewLayout = layout
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return calculateCellSize(indexPath: indexPath)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case IOStickyHeaderParallaxHeader:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath as IndexPath) as! DetailHeaderCell
            
            cell.configureCell(item: item)
            return cell
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func calculateCellSize(indexPath : IndexPath) -> CGSize {
        //
        var sizingCell : DetailTextCell
        
        switch indexPath.item {
        case 0:
            return CGSize(width: collectionView.bounds.size.width, height: 120)
        default:
            sizingCell = Bundle.main.loadNibNamed("DetailTextCell", owner: self, options: nil)?[0] as! DetailTextCell
        }
        sizingCell.configureCell(item: item, indexPath: indexPath)
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        //
        if sizingCell.text.text == nil {
            return CGSize(width: 0, height: 0)
        }
        let cellSize = sizingCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return cellSize
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : DetailCell
        var cellIdentifier = ""
        switch indexPath.item {
        case 0:
            cellIdentifier = "ratingCell"
        default:
            cellIdentifier = "detailCell"
        }
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DetailCell
        
        cell.configureCell(item: self.item, indexPath: indexPath)
        return cell
        
        
    }
    
    
    
    
    
    
}
