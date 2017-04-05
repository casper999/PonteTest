//
//  DetailCell.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

enum DetailCellType {
    case RATING
    case PLOT
    case AWARDS
}

class DetailCell: UICollectionViewCell {
    
    var item : Movie!
    
    var indexPath : IndexPath!
    
    var type : DetailCellType!
    
    
    func configureCell(item : Movie, indexPath : IndexPath) {
        self.item = item
        self.indexPath = indexPath
        switch self.indexPath.item {
        case 0:
            type = DetailCellType.RATING
        case 1:
            type = DetailCellType.PLOT
        default:
            type = DetailCellType.AWARDS
        }
        
        if indexPath.item % 2 == 0 {
            self.backgroundColor = UIColor.white
        } else {
            self.backgroundColor = UIColor.groupTableViewBackground
        }
    }
}
