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
    
    var ratingData = [MovieData]()
    var currentMovieData = [MovieData]()
    var searching = false
    
    let movies = MovieHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let favourites = storage.value(forKey: "favs") {
            ratingData = (favourites as! [Data]).map { (md) -> MovieData in
                return NSKeyedUnarchiver.unarchiveObject(with: md) as! MovieData
            }
        } else {
            storage.set(ratingData.map({ (md) -> Data in
                return NSKeyedArchiver.archivedData(withRootObject: md)
            }), forKey: "favs")
            storage.synchronize()
        }
    }
    
    func search() {
        currentMovieData = movies.searchForMovieWith(title: searchBar.text!)
        searching = true
        movieTable.reloadData()
    }
    
    @IBAction func clearSearch() {
        searching = false
        ratingData = (storage.value(forKey: "favs")! as! [Data]).map { (md) -> MovieData in
            return NSKeyedUnarchiver.unarchiveObject(with: md) as! MovieData
        }
        movieTable.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        search()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? currentMovieData.count : ratingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieTableViewCell
        print(ratingData[0])
        let movieTitle = searching ? currentMovieData[indexPath.row].title! : ratingData[indexPath.row].title!
        var titleParts = movieTitle.split(separator: " ")
        var year = "N/A"
        if titleParts.count > 1 {
            year = String(String(String(titleParts[titleParts.count-1]).split(separator: "(")[0]).split(separator: ")")[0])
            if let yi = Int(year) {
                if yi > 1900 {
                    _ = titleParts.popLast()
                } else {
                    year = "N/A"
                }
            } else {
                year = "N/A"
            }
        }
        let cleanedTitle = titleParts.joined(separator: " ")
        cell.movieTitle.text = cleanedTitle
        cell.movieYear.text = String(year)
        cell.movieTMBDid = searching ? currentMovieData[indexPath.row].tmdbId : ratingData[indexPath.row].tmdbId
        if !searching {
            cell.ratingButton1.isHidden = true
            cell.ratingButton2.isHidden = true
            cell.ratingButton3.isHidden = true
            cell.ratingButton4.isHidden = true
            cell.ratingButton5.isHidden = true
            cell.ratingLabel.text = "\(ratingData[indexPath.row].rating!)"
        } else {
            cell.ratingButton1.isHidden = false
            cell.ratingButton2.isHidden = false
            cell.ratingButton3.isHidden = false
            cell.ratingButton4.isHidden = false
            cell.ratingButton5.isHidden = false
            cell.ratingLabel.text = "Rating:"
        }
        cell.loadCover()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.dequeueReusableCell(withIdentifier: "movieCell")!.frame.height
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (_, actionIndexPath) in
            self.currentMovieData.remove(at: actionIndexPath.row)
            tableView.deleteRows(at: [actionIndexPath], with: .fade)
        }
        return [delete]
    }
    
}
