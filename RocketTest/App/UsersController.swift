//
//  UsersController.swift
//  RocketTest
//
//  Created by Maksim Romanov on 21.09.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit
import RealmSwift

class UsersController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var usersView = UsersView()
    let navigationItemTitle = "Контакты"
    var users = [User]()
    private lazy var realmUsers: Results<User> = try! RealmService.get(User.self)

    override func loadView() {
        super.loadView()
        self.view = usersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = navigationItemTitle
        self.usersView.tableView.dataSource = self
        self.usersView.tableView.delegate = self
        users = Array(realmUsers)
        loadUsers()
    }
    
    func loadUsers() {
        NetworkService.loadUsers { result in
            switch result {
            case let .success(users):
                try? RealmService.save(items: users)
                //self.users = users
                self.usersView.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UserCell")
        cell.textLabel?.text = users[indexPath.row].name
        return cell

    }
    
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userId = users[indexPath.row].name
        let detailsController = DetailsController(userId: userId)
        self.navigationController?.pushViewController(detailsController, animated: true)

    }

}
