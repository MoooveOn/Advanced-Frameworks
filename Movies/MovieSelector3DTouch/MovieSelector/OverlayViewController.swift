//
//  OverlayViewController.swift
//  MovieSelector
//
//  Created by Pavel Selivanov on 18.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit
import MovieSelectorBridge

class OverlayViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    var movieItem: Movie!

    func configurateView() {
        if let movie = movieItem {
            self.titleLabel.text = movie.title
            self.descriptionTextView.text = movie.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurateView()
    }
}

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.size.width - 20, height: 200)
//        
//        self.view.layer.cornerRadius = 5
//        self.view.layer.masksToBounds = true
//    }
