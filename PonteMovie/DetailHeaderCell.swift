//
//  DetailHeaderCell.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

class DetailHeaderCell: UICollectionReusableView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    var downloadTask: URLSessionDownloadTask?
    
    var item : Movie!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(item : Movie) {
        self.item = item
        if item.image == nil {
            downloadTask = imageView.loadImageWithURL(url: URL(string: (item.poster))!, callback: { (image) in
                self.item.image = image
                self.imageView.image = image
            })
        } else {
            self.imageView.image = item.image
        }
    }
    //
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let layoutAttributes:IOStickyHeaderFlowLayoutAttributes = layoutAttributes as? IOStickyHeaderFlowLayoutAttributes else { return }
        
        if layoutAttributes.progressiveness < 1 {
            self.imageHeightConstraint.constant = 380
            self.imageView.updateConstraintsIfNeeded()
        } else {
            self.imageHeightConstraint.constant = 380 * layoutAttributes.progressiveness
            self.imageView.updateConstraintsIfNeeded()
        }
    }
    
}
