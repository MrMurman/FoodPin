//
//  RestaurantTableViewController.swift
//  RestaurantTableViewController
//
//  Created by Андрей Бородкин on 03.08.2021.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    

    var restaurants = [Restaurant]()
    
    lazy var dataSource = configureDataSource()
    
    
    // MARK: -View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurants = Restaurant.all
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    // MARK: - Table view data source
    
    enum Section {
        case all
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {
        
        let cellIdentifier = "datacell"
        
        let dataSource = UITableViewDiffableDataSource<Section, Restaurant>(tableView: tableView, cellProvider: { tableView, indexPath, restaurant in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            
            cell.nameLabel.text = restaurant.name
            cell.thumbnailImageView.image = UIImage(named: restaurant.image)
            cell.locationLabel.text = restaurant.location
            cell.typeLabel.text = restaurant.type
            cell.tintColor = .systemYellow
            //cell.accessoryView = self.restaurant.isFavourite ? .checkmark : .none
            
            return cell
        }
        )
        return dataSource
    }
    
    
    // MARK: - UITableViewDelegate Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        // add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // add "reserve a table" action
        let reserveActionHandler = {(action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        
        
        // mark as favourite action
        let favoriteAction = {() -> UIAlertAction in
            //            let title: String = {
            //                if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            //                    return "Remove from favourite"
            //                } else {
            //                    return "Add to favourite"
            //                }
            //
            //            }()
            
            return UIAlertAction(title: {
                if tableView.cellForRow(at: indexPath)?.accessoryView != .none {
                    return "Remove from favourite"
                } else {
                    return "Add to favourite"
                }
                
            }(),
                                 style: .default) { (action: UIAlertAction) -> Void in
                let cell = tableView.cellForRow(at: indexPath)
                
                if cell?.accessoryView != .none {
                    cell?.accessoryView = .none
                    self.restaurants[indexPath.row].isFavourite = false
                } else {
                    let heart = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 70))
                    heart.addSubview(UIImageView(image: UIImage(systemName: "heart.fill", compatibleWith: nil)))
                    cell?.accessoryView = heart
                    self.restaurants[indexPath.row].isFavourite = true
                }
                
            }
        }()
        
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(reserveAction)
        optionMenu.addAction(favoriteAction)
        
        present(optionMenu, animated: true, completion: nil)
        
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
