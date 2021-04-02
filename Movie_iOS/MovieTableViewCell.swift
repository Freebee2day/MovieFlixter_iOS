//
//  MovieTableViewCell.swift
//  Movie_iOS
//
//  Created by Phoebe Zhong  on 4/1/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var ImgMovie: UIImageView!
    @IBOutlet weak var MovieName: UILabel!
    @IBOutlet weak var MovieSummary: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
