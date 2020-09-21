//
//  DetailsView.swift
//  RocketTest
//
//  Created by Maksim Romanov on 21.09.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit
import SnapKit

class DetailsView: UIView {
    var userImageView = UIImageView(image: UIImage(systemName: "gift.fill"))
    var userNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubviews()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSubviews() {
        //self.backgroundColor = .darkGray
        
        self.userImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.userImageView)

        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.userNameLabel)
        
    }

    func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(55)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userImageView.snp.centerY)
            make.leading.equalTo(userImageView.snp.trailing).offset(20)
        }
        
    }

}
