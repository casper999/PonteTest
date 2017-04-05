//
//  DetailRatingTitleCell.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

class DetailRatingTitleCell: DetailCell, TapSliderDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var ratingSlider: TapSlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell(item: Movie, indexPath : IndexPath) {
        super.configureCell(item: item, indexPath: indexPath)
        //
        self.ratingSlider.delegate = self
        //
        titleLabel.text = self.item.title
        yearLabel.text = "(\(self.item.year.intValue))"
        //
        let rating = UserDefaults.getMovieRating(movie: self.item)
        ratingSlider.setRating(value: rating)
        
    }
    
    func changeValue(value: Float) {
        self.ratingLabel.text = "Rating: \(value)"
        let rating = ratingSlider.getRawRating()
        self.item.rating = NSNumber(value: rating)
        UserDefaults.addRatingMovie(movie: self.item)
    }

}
