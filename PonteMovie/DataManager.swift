//
//  DataManager.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

protocol DataManagerDelegate {
    func success(source : [Movie])
    func error()
}


class DataManager: NSObject {
    
    var delegate : DataManagerDelegate?
    
    func getMovieList() {
        let uri = "http://ponte.hu/mobil/ios/movies.json"
        let url = URL(string: uri)
        //
        DispatchQueue.global(qos: .userInitiated).async {
            self.loadDataFromURL(url: url!, completion: { (data, error) in
                do {
                    let json = JSON(data: data! as Data)
                    let source = self.preapareMovieList(json: json)
                    DispatchQueue.main.async {
                        self.delegate?.success(source: source)
                    }
                    
                    
                } catch {
                    print(error)
                }
                
            })
        }
    }
    
    func loadDataFromURL(url : URL, completion:@escaping (_ data: Data?, _ error: Error?  ) -> Void ) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess          = true
        sessionConfig.timeoutIntervalForRequest     = 15
        sessionConfig.timeoutIntervalForResource    = 30
        sessionConfig.httpMaximumConnectionsPerHost = 1
        //
        let session = URLSession(configuration: sessionConfig)
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTask(with: url){ data, response, error in
            if let responseError = error {
                completion(nil, responseError)
                // Stop activity Indicator
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"ponte.hu", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    
                    
                    completion(nil, statusError)
                    
                } else {
                    
                    // Success, return data
                    
                    completion(data, nil)
                }
            }
        }
        
        loadDataTask.resume()
        
    }
    //
    func preapareMovieList(json : JSON) -> [Movie] {
        var array = [Movie]()
        if let jsonArray = json.array {
            for item in jsonArray {
                let movie = Movie.parse(json: item)
                array.append(movie)
            }
        }
        return array
    }
    
}
