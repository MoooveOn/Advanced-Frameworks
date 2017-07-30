//
//  MovieDetailViewController.swift
//  MovieSelector
//
//  Created by Pavel Selivanov on 18.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit
import MovieSelectorBridge

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTextView: UITextView!
    
    var movieObject: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurateView()
    }
    
    func configurateView() {
        movieTitleLabel.text = movieObject.title
        movieTextView.text   = movieObject.description
        
        if let availableImage = Movie.getImage(forMovie: movieObject) {
            movieImageView.image = availableImage
        }
    }

}
