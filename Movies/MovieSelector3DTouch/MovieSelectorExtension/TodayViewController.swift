//
//  TodayViewController.swift
//  MovieSelectorExtension
//
//  Created by Pavel Selivanov on 19.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit
import NotificationCenter
import MovieSelectorBridge

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var movieTableView: UITableView!
    
    var nowPlaying = [Movie]()
    
    var compact = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.separatorStyle = .none
        movieTableView.delegate       = self
        movieTableView.dataSource     = self
        
        loadData()
        
        //self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        widgetActiveDisplayModeDidChange(.compact, withMaximumSize: CGSize(width: 500, height: 200))
    }
    
    func loadData() {
        Movie.nowPlaying { (success: Bool, movieList: [Movie]?) in
            if success {
                self.nowPlaying = movieList!
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            }
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            compact = true
            self.preferredContentSize = CGSize(width: 0, height: 100)
        } else {
            compact = false
            self.preferredContentSize = CGSize(width: 0, height: 200)
        }
        
        movieTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if compact {
            return 2
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if nowPlaying.count > 0 {
            let movie = nowPlaying[indexPath.row]
            
            cell?.textLabel?.textColor = UIColor.white
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            cell?.textLabel?.text = movie.title
            
            Movie.getImage(forCell: cell!, withMovieObject: movie)
        }
        
        return cell!
    }
    
    func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
        loadData()
        completionHandler(.newData)
    }
    
}















