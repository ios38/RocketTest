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
    var nextFrom = 0
    var isLoading = false
    var indexSet = IndexSet()
    
    private lazy var realmUsers: Results<User> = try! RealmService.get(User.self)
    private var notificationToken: NotificationToken?

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
        
        self.notificationToken = realmUsers.observe({ [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                break
            case .update(_, _, _, _):
                let usersCountBeforeUpdate = self.users.count
                self.users = Array(self.realmUsers)
                self.indexSet = IndexSet(integersIn: usersCountBeforeUpdate..<self.users.count)
                //print("UsersController: notificationToken: indexSet: \(self.indexSet)")
                //self.usersView.tableView.reloadData()
                self.usersView.tableView.insertSections(self.indexSet, with: .automatic)
            case let .error(error):
                print(error)
            }
        })
    }
    
    func loadUsers() {
        NetworkService.loadUsers { result in
            switch result {
            case let .success(users):
                try? RealmService.save(items: users)
                //self.users = users
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

extension UsersController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > users.count - 2, !isLoading {
            print ("UsersController: DataSourcePrefetching: *** started ***")
            isLoading = true
            
            NetworkService.loadUsersWithStart(startFrom: nextFrom) { result, nextFrom in
                switch result {
                case let .success(users):
                    print ("UsersController: DataSourcePrefetching: result: \(users.count)")
                    print ("UsersController: DataSourcePrefetching: nextFrom: \(nextFrom)")
                    try? RealmService.save(items: users)
                    //self.users = users
                    self.nextFrom = nextFrom
                    self.isLoading = false
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
