//
//  MovieListController.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

class MovieListController: UIViewController, AdapterDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var serarchBar: UISearchBar!
    
    
    var adapter : MovieAdapter = MovieAdapter()
    
    var selectedItem : Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = self.collectionView
        adapter.delegate = self
        serarchBar.delegate = adapter
        adapter.initzialized()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            let vc = segue.destination as! MovieDetailController
            vc.item = selectedItem
        }
    }
 
    func selectItem(item: Movie) {
        self.selectedItem = item
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }

}


