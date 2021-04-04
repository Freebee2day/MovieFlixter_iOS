//
//  MoviesViewController.swift
//  Movie_iOS
//
//  Created by Phoebe Zhong  on 3/29/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITextViewDelegate{
    
    @IBOutlet weak var tvMovie: UITableView!
    
    var movieCollection = [[String:Any]]()  //create an array of dictionary.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMovie.delegate = self as? UITableViewDelegate
        tvMovie.dataSource = self
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
            // TODO: Get the array of movies
            //store the JSON result locally as dataDictionary.
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            // TODO: Store the movies in a property to use elsewhere
            //parse of the movie objects and store in "movieCollection"
            self.movieCollection = dataDictionary["results"] as! [[String:Any]]
            
        
              // TODO: Reload your table view data
            self.tvMovie.reloadData()
           }
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tvMovie.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        let singleMovie = movieCollection[indexPath.row]
        
        let singleMovieTitle = singleMovie["title"] as! String
        myCell.MovieName?.text = singleMovieTitle
        
        let singleMovieSummary = singleMovie["overview"] as! String
        myCell.MovieSummary?.text = singleMovieSummary
        
        let baseURL = "https://image.tmdb.org/t/p/w185/"
        let imgPath = singleMovie["poster_path"] as! String
        let imageURL = URL(string: baseURL + imgPath)
        
        myCell.ImgMovie.af.setImage(withURL: imageURL!)
        
       
        
        return myCell
    }
    

    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
     Get the new view controller using segue.destination.
     Pass the selected object to the new view controller.
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         //sender is the movie cell that gets tapped on.
        let tappedcell = sender as! UITableViewCell
        let index = tvMovie.indexPath(for: tappedcell)!
        
        let selectedMovie = movieCollection[index.row]
        
        let mydetailVC = segue.destination as! DetailsViewController
        
        mydetailVC.sentMovie = selectedMovie
        
        tvMovie.deselectRow(at: index, animated: true)
        
        
        
    }
}
