//
//  RestaurantDetailViewController.swift
//  RestaurantDetailViewController
//
//  Created by Андрей Бородкин on 16.08.2021.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    
    //@IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!
    
    var passedRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        guard let restaurant = passedRestaurant else {return}
        
        // Configure header view
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        
        let heartImage = restaurant.isFavourite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = restaurant.isFavourite ? .systemYellow : .white
        headerView.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .systemOrange
//        let textLabels: [UILabel] = [UILabel(), UILabel(), UILabel()]
//        var size:CGFloat = 24
//
//        textLabels.forEach { label in
//            label.font = UIFont.systemFont(ofSize: size)
//            size -= 6
//            label.textColor = .white
//            label.textAlignment = .center
//        }
//
//        let vStack = UIStackView(arrangedSubviews: textLabels)
//        vStack.axis = .vertical
//        vStack.frame = CGRect(x: 20, y: 110, width: view.frame.width-40, height: 90)
//        vStack.backgroundColor = .darkGray
//        vStack.layer.cornerRadius = 10
//        vStack.distribution = .fillProportionally
//        vStack.spacing = 5
//
//        restaurantImageView.addSubview(vStack)
//
//        if let restaurant = passedRestaurant {
//            restaurantImageView.image = UIImage(named: restaurant.image)
//            textLabels[0].text = restaurant.name
//            textLabels[1].text = restaurant.type
//            textLabels[2].text = restaurant.location
//        }
        
    }
    

}


extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let restaurant = passedRestaurant else {fatalError()}
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
            
            cell.descriptionLabel.text = restaurant.description
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTwoColumnCell.self), for: indexPath) as! RestaurantDetailTwoColumnCell
            
            cell.column1TitleLabel.text = "Address"
            cell.column1TextLabel.text = restaurant.location
            cell.column2TitleLabel.text = "Phone"
            cell.column2TextLabel.text = restaurant.phone
            
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for data in view controller")
        }
    }
}
