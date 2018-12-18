//
//  Hit.swift
//  Engineer Ai Assignment
//
//  Created by Zhandos Bolatbekov on 12/18/18.
//  Copyright © 2018 zhandos. All rights reserved.
//

import Alamofire

typealias JSONObject = [String: Any]

struct Hit {
    let title: String
    let createdAt: String
    
    init(title: String, createdAt: String) {
        self.title = title
        self.createdAt = createdAt
    }
    
    static func getHits(inPage page: Int, completion: @escaping ([Hit]) -> Void) {
        let urlString = "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=\(page)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 15
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let json = value as? JSONObject else {
                    print("Invalid json")
                    completion([])
                    return
                }
                let hitsJSON = json["hits"] as! [JSONObject]
                let hits = hitsJSON.map{
                    Hit(title: $0["title"] as! String,
                        createdAt: $0["created_at"] as! String)
                }
                completion(hits)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}
