//
//  Movie.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

class Movie: NSObject, NSCoding {
    var title : String
    var year : NSNumber
    var plot : String?
    var poster : String
    var rating : NSNumber?
    var image : UIImage?
    var awards : String?
    
    init(title: String, year: NSNumber, plot: String, poster: String, rating : NSNumber?, awards : String?) {
        self.title = title
        self.year = year
        self.plot = plot
        self.poster = poster
        self.rating = rating
        self.awards = awards
        
    }
    
    convenience init(title: String, year: NSNumber, plot: String, poster: String, rating: NSNumber?) {
        self.init(title: title, year: year, plot: plot, poster: poster, rating: rating, awards: nil)
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let year = aDecoder.decodeObject(forKey: "year") as! NSNumber
        let plot = aDecoder.decodeObject(forKey: "plot") as! String
        let poster = aDecoder.decodeObject(forKey: "poster") as! String
        let rating = aDecoder.decodeObject(forKey: "rating") as? NSNumber
        let awards = aDecoder.decodeObject(forKey: "awards") as? String
        
        //
        self.init(title: title, year: year, plot: plot, poster: poster, rating: rating, awards: awards)
        
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(year, forKey: "year")
        aCoder.encode(plot, forKey: "plot")
        aCoder.encode(poster, forKey: "poster")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(awards, forKey: "awards")
    }
    //
    class func parse(json: JSON) -> (Movie) {
        
        let title   = json["title"].string ?? ""
        let year    = json["year"].string ?? ""
        let plot    = json["plot"].string ?? ""
        let poster  = json["poster"].string ?? ""
        let awards  = json["awards"].string ?? nil
//        let rating  = stationJSON["longDesc"].string ?? ""
        
        let rat = json["rating"].float ?? 0
        
        let y = (year as NSString).integerValue
        let yearNumber = NSNumber(integerLiteral: y)
        
        let rating = NSNumber(value: (rat * 2))
        
        
        let movie = Movie(title: title, year: yearNumber, plot: plot, poster: poster, rating: rating, awards: awards)
        return movie
    }

    
    
}
