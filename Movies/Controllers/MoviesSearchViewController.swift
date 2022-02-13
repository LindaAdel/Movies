//
//  MoviesSearchViewController.swift
//  Movies
//
//  Created by Linda adel on 2/12/22.
//

import UIKit

class MoviesSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UITextFieldDelegate {
    
    var filteredMovies : [MoviesResults]?
    var searchResult :  [MoviesResults]?
    var delayTimer: Timer?

    //MARK: IBOutlets
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.delegate = self
        }
    }
    
    @IBOutlet weak var searchList: UITableView!
    {
        didSet{
            searchList.delegate = self
            searchList.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchList.isHidden = true
        setUpSearchTextField()
      
    }
    func setUpSearchTextField(){
        searchTextField.leftViewMode = .always
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchTextField.leftView = searchIcon
        
    }
    //MARK: textfield search methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }
     
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        delayTimer?.invalidate()
         //input text
        if let inputText = textField.text {
            let searchText  = inputText + string
           
            // …schedule a timer for 0.5 seconds
            delayTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performSearch), userInfo: ["searchString": searchText], repeats: true)
            DispatchQueue.main.async {
                self.searchList.reloadData()
            }
        }
       
         return true
     }
    @objc func performSearch(_ timer: Timer) {
        if let data = timer.userInfo as? [String : String] {
            if let searchText = data["searchString"] {
                searchResult = filteredMovies?.filter({ ($0.title?.localizedCaseInsensitiveContains(searchText))!})
                print("searchResult \(String(describing: searchResult))")
                DispatchQueue.main.async {
                    self.searchList.isHidden = false
                    
                }
            }
            
        }
    }
    
    //MARK: table view methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? MovieDetailViewController{
            if let selectedMovie = searchResult?[indexPath.row]{
                movieDetailVC.movie = selectedMovie

            }
            movieDetailVC.modalPresentationStyle = .fullScreen
            self.present(movieDetailVC, animated: true, completion: nil)}
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let moviesCount =  searchResult?.count {
            return moviesCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        if let movieCell = cell as? MoviesTableViewCell{
            if let posterPath = searchResult?[indexPath.row].poster_path ,let vote = searchResult?[indexPath.row].vote_average {
                movieCell.moviePoster.sd_setImage(with:URL(string: URLs.getMoviePosterImageURL(posterPath: posterPath)) )
                movieCell.movieName.text = searchResult?[indexPath.row].title
                movieCell.movieReleaseDate.text = searchResult?[indexPath.row].release_date
                movieCell.movieVoteAverage.text = String(vote)
            }
            
        }
        return cell
    }
    

    
}
