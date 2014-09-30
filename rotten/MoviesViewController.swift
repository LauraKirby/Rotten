//
//  MoviesViewController.swift
//  rotten
//
//  Created by Laura Kirby on 9/27/14.
//  Copyright (c) 2014 Laura. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let YourApiKey = "5y3retajrqzcbqyg79kg7sdp"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            
//            println("dictionary: \(dictionary)")
            
            self.movies = dictionary["movies"] as [NSDictionary]
            self.tableView.reloadData()
        })

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        
        println("number of movies: \(movies.count)")
        return movies.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        
        var movie = movies [indexPath.row]
        
        println("setting data for row: \(indexPath.row)")
        println("data: \(movie)")
        
        cell.titleLabel.text = movie ["title"] as? String
        cell.synopsisLabel.text = movie ["synopsis"] as? String

        var posters = movie ["posters"] as NSDictionary
        var posterURL = posters ["thumbnail"] as String
        
        cell.posterView.setImageWithURL(NSURL (string: posterURL))
        
        
      //  cell.textLabel!.text = "Hello, I'm at row: \(indexPath.row), section: \(indexPath.section)"
       
        
        return cell
    }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
