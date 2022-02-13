//
//  URLs.swift
//  Movies
//
//  Created by Linda adel on 2/12/22.
//

import Foundation

struct URLs {
    public static var getMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=21d3fd73c011bff94f9ef84b4924d747&la%20nguage=en-US&page=1"
    public static func getMoviePosterImageURL(posterPath : String) -> String {
        let imageURL = "http://image.tmdb.org/t/p/w92\(posterPath)"
         return imageURL
       
    }
}
