//
//  DetailTextCell.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

class DetailTextCell: DetailCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var text: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell(item: Movie, indexPath : IndexPath) {
        super.configureCell(item: item, indexPath: indexPath)
        if type == DetailCellType.PLOT {
            configurePlotCell()
        }
        if type == DetailCellType.AWARDS {
            configureAwardCell()
        }
    }
    
    private func configurePlotCell() {
        self.title.text = "Plot"
        self.text.text = item.plot
    }
    
    private func configureAwardCell() {
        self.title.text = "Awards"
        self.text.text = item.awards
    }
    
}
