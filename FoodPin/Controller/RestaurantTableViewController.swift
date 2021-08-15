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
    
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {
        
        let cellIdentifier = "datacell"
        
        let dataSource = RestaurantDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, restaurant in
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {return UISwipeActionsConfiguration()}
        
        // delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
            // call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // share action
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + restaurant.name
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
            // configure both actions as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let _ = self.dataSource.itemIdentifier(for: indexPath) else {return UISwipeActionsConfiguration()}
        
        let favouriteAction = UIContextualAction(style: .normal, title: {
            if tableView.cellForRow(at: indexPath)?.accessoryView != .none {
                return "Remove from favourite"
            } else {
                return "Mark as favourite"
            }
            
        }()) { (action, sourceView, completionHandler) in
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
            completionHandler(true)
            
        }
        
        favouriteAction.backgroundColor = UIColor.systemPink
        favouriteAction.image = UIImage(systemName: {
            if tableView.cellForRow(at: indexPath)?.accessoryView != .none {
            return "heart.slash.fill"
        } else {
            return "heart.fill"
        }
            
        }())
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favouriteAction])
        
        return swipeConfiguration
    }
    
}
