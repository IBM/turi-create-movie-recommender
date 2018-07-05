//
//  FavSearchViewController.swift
//  MovieRecommender
//
//  Created by Tanmay Bakshi on 2018-07-04.
//  Copyright © 2018 Tanmay Bakshi. All rights reserved.
//

import UIKit

let storage = UserDefaults.standard

class FavSearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var movieTable: UITableView!
    
    var currentMovieData = [(movieId: String, title: String, tmdbId: String)]()
    
    let movies = MovieHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let favourites = storage.value(forKey: "favs") {
            currentMovieData = favourites as! [(movieId: String, title: String, tmdbId: String)]
        } else {
            storage.set(currentMovieData, forKey: "favs")
        }
    }
    
    func search() {
        currentMovieData = movies.searchForMovieWith(title: searchBar.text!)
        movieTable.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        search()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieTableViewCell
        let movieTitle = currentMovieData[indexPath.row].title
        var titleParts = movieTitle.split(separator: " ")
        var year = "N/A"
        if titleParts.count > 1 {
            year = String(String(String(titleParts[titleParts.count-1]).split(separator: "(")[0]).split(separator: ")")[0])
            if let _ = Int(year) {
                _ = titleParts.popLast()
            } else {
                year = "N/A"
            }
        }
        let cleanedTitle = titleParts.joined(separator: " ")
        cell.movieTitle.text = cleanedTitle
        cell.movieYear.text = String(year)
        cell.movieTMBDid = currentMovieData[indexPath.row].tmdbId
        cell.loadCover()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.dequeueReusableCell(withIdentifier: "movieCell")!.frame.height
    }
    
}
