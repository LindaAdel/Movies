//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Linda adel on 2/12/22.
//

import UIKit
import SDWebImage

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var moviesService : MoviesService?
    var moviesResults : [MoviesResults]?
    //MARK: IBOutlets
    @IBOutlet weak var moviesList: UITableView!{
        didSet{
            moviesList.delegate = self
            moviesList.dataSource =  self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesService = MoviesService()
        moviesResults = [MoviesResults]()
        fetchMoviesDataFromAPI()
    
        
    }
    //MARK: IBActions
    
    @IBAction func searchForAMovie(_ sender: UIBarButtonItem) {
        if let moviesSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "moviesSearch") as? MoviesSearchViewController {
            moviesSearchVC.filteredMovies  = moviesResults
            moviesSearchVC.modalPresentationStyle = .fullScreen
            self.present(moviesSearchVC, animated: true, completion: nil)}
    }
    
    //MARK: table view methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? MovieDetailViewController{
            if let selectedMovie = moviesResults?[indexPath.row]{
                movieDetailVC.movie = selectedMovie

            }
            movieDetailVC.modalPresentationStyle = .fullScreen
            self.present(movieDetailVC, animated: true, completion: nil)}
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let moviesCount =  moviesResults?.count {
            return moviesCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        if let movieCell = cell as? MoviesTableViewCell{
            if let posterPath = moviesResults?[indexPath.row].poster_path ,let vote = moviesResults?[indexPath.row].vote_average {
                movieCell.moviePoster.sd_setImage(with:URL(string: URLs.getMoviePosterImageURL(posterPath: posterPath)) )
                movieCell.movieName.text = moviesResults?[indexPath.row].title
                movieCell.movieReleaseDate.text = moviesResults?[indexPath.row].release_date
                movieCell.movieVoteAverage.text = String(vote)
            }
            
        }
        return cell
    }
    
    
    
    //MARK: fetch movies data
    func fetchMoviesDataFromAPI(){
        moviesService?.fetchMoviesData(completion: { (moviesResult, error) in
            if let error : Error = error{
                print("error in fetching \(error.localizedDescription)")
            }else{
             
                    self.moviesResults = moviesResult
                DispatchQueue.main.async {
                    self.moviesList.reloadData()
                }
                
            }
        })
    }
    
}
