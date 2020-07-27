//
//  MainServer.swift
//  Task_Pryaniky
//
//  Created by Анна Мельхова on 27.07.2020.
//  Copyright © 2020 Anna Melkhova. All rights reserved.
//

import Foundation
import Alamofire

extension MainService {
    enum Routes {
        case sample
        var path: String {
            switch self {
            case .sample:
                return "/static/json/sample.json"
            }
        }
    }
}

class MainService {
    
    let URL = "https://pryaniky.com";
    
    func fetchData(completionHandler: @escaping (Result<AllData, Error>) -> Void)  {
        
        let sampleUrl = URL + Routes.sample.path
        
        AF.request(sampleUrl, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            let result: Result<AllData, Error>
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(AllData.self, from: response.data!)
                result = .success(data)
            } catch let error {
                print("Ошибка в получении информации: \(error)")
                result = .failure(error)
            }
            completionHandler(result)
        }
    }
}

