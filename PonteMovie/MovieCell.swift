//
//  MovieCell.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    var item : Movie?
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
    
    func configureCell(movie : Movie?) {
        self.item = movie
        //
        movieTitle.text = item?.title
        if ((item?.year) != nil) {
            if item!.year > 0 {
                movieTitle.text = "\(String(describing: item!.title)) (\(String(describing: item!.year.intValue)))"
            }
        }
        
        
        if item?.image == nil {
            downloadTask = movieImage.loadImageWithURL(url: URL(string: (item?.poster)!)!, callback: { (image) in
                self.item?.image = image
                self.movieImage.image = image
                
            })
        } else {
            self.movieImage.image = item?.image
        }
        drawBorder()
    }
    override func prepareForReuse() {
        downloadTask?.cancel()
        movieImage.image = nil
        movieTitle.text = ""
    }
    
    func drawBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
}
