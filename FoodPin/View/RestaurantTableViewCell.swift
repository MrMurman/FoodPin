//
//  RestaurantTableViewCell.swift
//  RestaurantTableViewCell
//
//  Created by Андрей Бородкин on 03.08.2021.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tintColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
