//
//  MovieTableViewCell.swift
//  MovieRecommender
//
//  Created by Tanmay Bakshi on 2018-07-05.
//  Copyright © 2018 Tanmay Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var coverPicture: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieYear: UILabel!
    
    var movieTMBDid = ""
    
    let img_baseurl = "https://image.tmdb.org/t/p/w185/"
    let tmdb_baseurl = "https://api.themoviedb.org/3/movie/"
    let tmdb_apikey = "66d3c47746f7d6433ba99cae9588d144"
    
    func loadCover() {
        Alamofire.request(tmdb_baseurl + movieTMBDid, method: .get, parameters: ["api_key": tmdb_apikey]).responseSwiftyJSON { (tmdbResponse) in
            if let tmdbJSON = tmdbResponse.value {
                let posterURL = self.img_baseurl + tmdbJSON["poster_path"].stringValue
                Alamofire.request(posterURL, method: .get).responseData(completionHandler: { (posterResponse) in
                    if let posterData = posterResponse.data {
                        DispatchQueue.main.async {
                            self.coverPicture.image = UIImage(data: posterData)
                        }
                    }
                })
            }
        }
    }
    
}
