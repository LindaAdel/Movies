//
//  MoviesService.swift
//  Movies
//
//  Created by Linda adel on 2/12/22.
//

import Foundation
import Alamofire

class MoviesService {
    
    var moviesResults = [MoviesResults]()
    
    func fetchMoviesData(completion : @escaping ([MoviesResults]?, Error?)->()){
        
        AF.request(URLs.getMoviesURL)
            .validate()
            
            .responseDecodable(of: Movies.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let moviesData = response.value else { return }
                    if let moviesDataResults = moviesData.results{
                        for result in moviesDataResults{
                            
                            self.moviesResults.append(result)
                            
                        }
                        
                        completion(self.moviesResults,nil)
                        
                    }
    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
}
