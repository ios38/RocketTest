//
//  UsersController.swift
//  RocketTest
//
//  Created by Maksim Romanov on 21.09.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class UsersController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var usersView = UsersView()
    let navigationItemTitle = "Контакты"

    override func loadView() {
        super.loadView()
        self.view = usersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = navigationItemTitle
        self.usersView.tableView.dataSource = self
        self.usersView.tableView.delegate = self
        loadUsers()
    }
    
    func loadUsers() {
        
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UserCell")
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell

    }
    
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userId = "\(indexPath.row)"
        let detailsController = DetailsController(userId: userId)
        self.navigationController?.pushViewController(detailsController, animated: true)

    }

}
