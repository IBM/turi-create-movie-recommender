//
//  MovieHandler.swift
//  MovieRecommender
//
//  Created by Tanmay Bakshi on 2018-07-04.
//  Copyright © 2018 Tanmay Bakshi. All rights reserved.
//

import Foundation
import CSV

class MovieHandler {
    
    var data: [String: [Any]] = ["movieId": [], "title": [], "tmdbId": []]
    
    var backend = "https://movierecommend.ngrok.io/"
    
    init() {
        if let movieIndex = storage.value(forKey: "movieIndex") {
            print("Loading movie index data from defaults...")
            data = movieIndex as! [String: [Any]]
            print("Done loading movie index data...")
        } else {
            print("It seems like this is first time you're running this application. Please wait for a few moments as the movie database is indexed.")
            if let moviesCSVFile = Bundle.main.path(forResource: "movies", ofType: "csv") {
                if let linksCSVFile = Bundle.main.path(forResource: "links", ofType: "csv") {
                    if let moviesStream = InputStream(fileAtPath: moviesCSVFile) {
                        if let linksStream = InputStream(fileAtPath: linksCSVFile) {
                            do {
                                let moviesCSV = try CSVReader(stream: moviesStream)
                                let linksCSV = try CSVReader(stream: linksStream)
                                while let moviesRow = moviesCSV.next() {
                                    if let linksRow = linksCSV.next() {
                                        if moviesRow[0] != linksRow[0] {
                                            print("Problem with movie/link parsing! Aborting data loop!")
                                            break
                                        } else {
                                            data["movieId"]!.append(moviesRow[0])
                                            data["title"]!.append(moviesRow[1])
                                            data["tmdbId"]!.append(linksRow[2])
                                        }
                                    } else {
                                        print("Problem with movie/link parsing! Aborting data loop!")
                                        break
                                    }
                                }
                            } catch {
                                print("Exception occured while handling movies.csv and links.csv.")
                            }
                        } else {
                            print("Unable to stream links.csv.")
                        }
                    } else {
                        print("Unable to stream movies.csv.")
                    }
                } else {
                    print("Unable to load links.csv - did you forget to run the setup script in the main directory?")
                }
            } else {
                print("Unable to load movies.csv - did you forget to run the setup script in the main directory?")
            }
            storage.set(data, forKey: "movieIndex")
            storage.synchronize()
            print("Movie database indexing is complete. All subsequent runs will be much faster.")
        }
    }
    
    private func movieWith(index: Int) -> (movieId: String, title: String, tmdbId: String)? {
        if (0..<data["movieId"]!.count).contains(index) {
            return (movieId: data["movieId"]![index] as! String, title: data["title"]![index] as! String, tmdbId: data["tmdbId"]![index] as! String)
        }
        return nil
    }
    
    func searchForMovieWith(movieId: String) -> (movieId: String, title: String, tmdbId: String)? {
        for (index, value) in data["movieId"]!.enumerated() {
            if value as! String == movieId {
                return movieWith(index: index)
            }
        }
        return nil
    }
    
    func searchForMovieWith(title: String, k: Int = 10) -> [(movieId: String, title: String, tmdbId: String)] {
        var title_distance = [(Double, Int)]()
        for (index, value) in data["title"]!.enumerated() {
            title_distance.append((Double(title.lowercased().distance(to: (value as! String).lowercased())), index))
            if (value as! String).lowercased().contains(title.lowercased()) {
                title_distance[title_distance.count-1].0 = title_distance.last!.0 / 1.5
            }
        }
        title_distance.sort(by: {$0.0 < $1.0})
        var movies = [(movieId: String, title: String, tmdbId: String)]()
        for i in 0..<k {
            movies.append(movieWith(index: title_distance[i].1)!)
        }
        return movies
    }
    
}
