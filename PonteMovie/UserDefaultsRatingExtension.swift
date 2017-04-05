//
//  UserDefaultsRatingExtension.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 05..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

extension UserDefaults {

    class func addRatingMovie(movie : Movie) {
        if let decodedData = self.standard.value(forKey: "ratings") as? Data {
            if var ratings = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Movie] {
                let movies = ratings.filter() {$0.title == movie.title}
                if movies.isEmpty == false {
                    let item = movies[0]
                    item.rating = movie.rating
                } else {
                    ratings.append(movie)
                }
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: ratings)
                self.standard.set(encodedData, forKey: "ratings")
                
            }
        } else {
            var ratings = [Movie]()
            ratings.append(movie)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: ratings)
            self.standard.set(encodedData, forKey: "ratings")
        }
    }
    
    class func getMovieRating(movie : Movie) -> Float {
        if let decodedData = self.standard.value(forKey: "ratings") as? Data {
            if let ratings = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Movie] {
                let movies = ratings.filter() {$0.title == movie.title}
                if movies.isEmpty == false {
                    let item = movies[0]
                    if item.rating != nil {
                        return item.rating!.floatValue
                    }
                    return 0
                }
                return 0
                
            }
            return 0
            
        }
        return 0
        
        
        
    }

}
