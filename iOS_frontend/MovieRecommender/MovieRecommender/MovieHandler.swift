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
    
    static var shared = MovieHandler()
    
    var data: [String: [Any]] = ["movieId": [], "title": [], "imdbId": []]
    
    var backend = "https://movierecommend.ngrok.io/"
    
    init() {
        if let movieIndex = storage.value(forKey: "movieIndex") {
            data = movieIndex as! [String: [Any]]
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
                                            data["imdbId"]!.append(linksRow[1])
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
    
}
