//
//  MovieAdapter.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

protocol AdapterDelegate {
    func selectItem(item : Movie)
    
}

class MovieAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, DataManagerDelegate, UICollectionViewDelegateFlowLayout {
    func error() {
        //
    }

    var delegate : AdapterDelegate?
    var collectionView : UICollectionView?
    var searchBar : UISearchBar?
    var dataSource = [Movie]()
    var searchSource = [Movie]()
    var cellIdentifier : String = "movieCell"
    var searching : Bool = false
    var searchTimer : Timer?
    
    lazy var movieNib : UINib = {
       let nib = UINib(nibName: "MovieCell", bundle: Bundle.main)
       return nib
    }()
    
    
    func initzialized() {
        self.collectionView?.register(movieNib, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        //
        let manager = DataManager()
        manager.delegate = self
        manager.getMovieList()
        
    }
    //DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching == true {
            return searchSource.count
        } else {
            return (dataSource.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var item : Movie!
        if searching == true {
            item = self.searchSource[indexPath.item]
        } else {
            item = self.dataSource[indexPath.item]
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCell
        cell.configureCell(movie: item)
        //
        return cell
    }
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2 - 10
        let height = collectionView.frame.size.height / 2 - 10
        return CGSize(width: width, height: height)
    }
    
    
    //
    func success(source: [Movie]) {
        self.dataSource = source
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.dataSource[indexPath.item]
        self.delegate?.selectItem(item: item)
    }
    
    func resetSearch() {
        self.searchBar?.endEditing(true)
        self.searchBar = nil
        searching = false
    }
    
    
    
}
extension MovieAdapter : UISearchBarDelegate {
    

    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count  >= 2 {
            //
            searchTimer?.invalidate()
            searchTimer = nil
            searchSource = [Movie]()
            searchFiltered(searchText: searchText)
            
            for item in searchSource {
                print(item.title)
            }
            
            searching = true
            self.collectionView?.reloadData()

        }
        if searchText == "" {
            searching = false
            self.collectionView?.reloadData()
            searchTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(resetSearch), userInfo: nil, repeats: false)
        }
    }
    func searchFiltered(searchText : String) {
        searchSource = dataSource.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
    }
    
}
