//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Linda adel on 2/12/22.
//

import UIKit
import SDWebImage


class MovieDetailViewController: UIViewController {
    
    var movie : MoviesResults?
    //MARK: IBOutlets
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieVote: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMovieDetails()
       
    }
    
//MARK: IBActions
    
    
    @IBAction func backToMoviesList(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpMovieDetails(){
        if let posterPath =  movie?.poster_path  , let vote = movie?.vote_average {
            moviePoster.sd_setImage(with: URL(string: URLs.getMoviePosterImageURL(posterPath:posterPath)))
            movieTitle.text = movie?.title
            movieReleaseDate.text = movie?.release_date
            movieVote.text = String(vote)
            movieDescription.text = movie?.overview
            
        }
        
    }

}

