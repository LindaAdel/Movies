//
//  MoviesTableViewCell.swift
//  Movies
//
//  Created by Linda adel on 2/12/22.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    @IBOutlet weak var movieVoteAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}

