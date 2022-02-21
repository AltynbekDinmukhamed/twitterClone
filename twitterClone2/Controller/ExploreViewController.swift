//
//  ExploreViewController.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 10.01.2022.
//

import UIKit

private let reuseIdentifier = "userCell"

class ExploreViewController: UITableViewController {

    //MARK: - Properties
    
    private var user = [User]() { didSet{ tableView.reloadData() } }
    
    private var userFilter = [User]() { didSet{ tableView.reloadData() } }
    
    private var isSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchUser()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: -API
    
    func fetchUser() {
        UserService.shared.fetchUser { users in
            self.user = users
        }
    }
    
    //MARK: - Selectros

    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        view.endEditing(true)
        navigationItem.title = "Explore"
        navigationController?.navigationBar.barStyle = .default
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search a user"
        searchController.searchBar.endEditing(true)
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: -Extensions-

//MARK: - extension of UITableView
extension ExploreViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchMode ? userFilter.count : user.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = isSearchMode ? userFilter[indexPath.row] : user[indexPath.row]
        cell.user = user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearchMode ? userFilter[indexPath.row] : user[indexPath.row]
        let controller = ProfileViewController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
    }
}
// MARK: - extension if UISearch
extension ExploreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        tableView.reloadData()
        
        
        userFilter = user.filter({ $0.username.contains(searchText) })
    }
    
}
