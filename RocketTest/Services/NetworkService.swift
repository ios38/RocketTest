//
//  NetworkService.swift
//  RocketTest
//
//  Created by Maksim Romanov on 21.09.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    static let session: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        let session = Alamofire.Session(configuration: config)
        return session
    }()
    
    static func loadUsers(completion: ((Swift.Result<[User], Error>) -> Void)? = nil) {
        let baseUrl = "https://open.rocket.chat/api/v1/channels.members?roomName=general"
        
        let params: Parameters = [
            "count": 10
        ]
        
        let headers: HTTPHeaders  = [
            "X-User-Id": "e2qQQA3adTsZGN8et",
            "X-Auth-Token": "-hCxpEnhskSaaMgLSCznQHm3n3VQ8nu5KFTB2l83Is5"
        ]

        NetworkService.session.request(baseUrl, method: .get, parameters: params, headers: headers).responseJSON { response in
            switch response.result {
            case let .success(data):
                let json = JSON(data)
                let usersJSONs = json["members"].arrayValue
                let users = usersJSONs.map { User(from: $0) }
                //print("NetworkService: loaded \(users.count) users")
                completion?(.success(users))
            case let .failure(error):
                completion?(.failure (error))
            }
        }
    }
    
    static func loadUsersWithStart(startFrom: Int? = nil, completion: ((Swift.Result<[User], Error>, Int) -> Void)? = nil) {
        
    }

}
