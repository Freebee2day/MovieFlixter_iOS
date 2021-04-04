//
//  DetailsViewController.swift
//  Movie_iOS
//
//  Created by Phoebe Zhong  on 4/2/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {
    
    var sentMovie : [String:Any]!

    @IBOutlet weak var imgBackdrop: UIImageView!
    
    @IBOutlet weak var imgPosterDetail: UIImageView!
    
    @IBOutlet weak var DetailTitle: UILabel!
    
    @IBOutlet weak var DetailSummary: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailTitle.text = sentMovie ["title"] as? String
        
       
        
        DetailSummary.text = sentMovie ["overview"] as? String
        DetailSummary.sizeToFit()
        
        let baseURL = "https://image.tmdb.org/t/p/w185/"
        let imgPath = sentMovie ["poster_path"] as! String
        let imageURL = URL(string: baseURL + imgPath)
        
        imgPosterDetail.af.setImage(withURL: imageURL!)
        
        let baseBDURL = "https://image.tmdb.org/t/p/w1280/"
        let BackDropPath = sentMovie ["backdrop_path"] as! String
        let BackDropURL = URL(string: baseBDURL + BackDropPath)
            
        imgBackdrop.af.setImage(withURL: BackDropURL!)
        
        
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
