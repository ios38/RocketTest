//
//  DetailsController.swift
//  RocketTest
//
//  Created by Maksim Romanov on 21.09.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    var userId: String
    var detailsView = DetailsView()
    
    init(userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsView.userNameLabel.text = "\(userId)"
    }
    
}
