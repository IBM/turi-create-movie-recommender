//
//  FavSearchViewController.swift
//  MovieRecommender
//
//  Created by Tanmay Bakshi on 2018-07-04.
//  Copyright © 2018 Tanmay Bakshi. All rights reserved.
//

import UIKit

let storage = UserDefaults.standard

class FavSearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var movieTable: UITableView!
    
    var currentMovieData = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let favourites = storage.value(forKey: "favs") {
            currentMovieData = favourites as! [Int]
        } else {
            storage.set(currentMovieData, forKey: "favs")
        }
    }
    
    func search() {
        currentMovieData = []
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        search()
        return true
    }
    
}
