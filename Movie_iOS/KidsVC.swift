//
//  KidsVC.swift
//  Movie_iOS
//
//  Created by Phoebe Zhong  on 4/3/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import AlamofireImage

class KidsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var kidsCollection = [[String:Any]]()
    
    
    @IBOutlet weak var KidCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        KidCollectionView.delegate = self
        KidCollectionView.dataSource = self
        
        let layout = KidCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let myWidth = view.frame.size.width / 3
        layout.itemSize =  CGSize(width: myWidth, height: myWidth * 3 / 2)
        
        
        

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/529203/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.kidsCollection = dataDictionary["results"] as! [[String : Any]]
            
            

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            
            self.KidCollectionView.reloadData()

           }
        }
        task.resume()
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kidsCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myGridCell = KidCollectionView.dequeueReusableCell(withReuseIdentifier: "KidGridCell", for: indexPath) as! KidGridCell
        
        let singleKidsMovie = kidsCollection[indexPath.item]
        
        //print(singleKidsMovie)
        
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let imgPath = singleKidsMovie["poster_path"] as! String
        let imageURL = URL(string: baseURL + imgPath)


        myGridCell.ImgGridCell.af.setImage(withURL: imageURL!)
        
        
        return myGridCell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
