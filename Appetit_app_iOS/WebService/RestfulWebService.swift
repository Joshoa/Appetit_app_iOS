//
//  RestfulWebService.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 12/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import UIKit
import CoreData

public class RestfulWebService: Params {
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60.0
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    private static func genericWS(method: String = "GET", httpBody: Data? = nil, parameters: [String: String]?, urlString: String, onSucces: @escaping (_ responseToken: Data?) -> Void, onFailure: @escaping () -> Void) throws {
        var request: URLRequest
        if method == "GET" {
            guard var components = URLComponents(string: urlString) else { return }
            if let parameters = parameters {
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
                }
            }
            request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
        } else {
            guard let url = URL(string: urlString) else {return}
            request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
            request.httpBody = httpBody
        }
        var ex: Error?
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                ex = error!
                DispatchQueue.main.async {
                    onFailure()
                }
            } else {
                DispatchQueue.main.async {
                    onSucces(data)
                }
            }
        }
        dataTask.resume()
        if ex != nil {
            throw ex!
        }
    }
    
    public static func logingWS(context: NSManagedObjectContext, login: String, password: String, callback: @escaping (_ responseToken: User) -> Void) {
        let parameters = [ "email" : login,
                           "password" : password ]
        do {
            try genericWS(parameters: parameters, urlString: DEFAULT_WS_URI + USER_LOGIN + "/", onSucces: { data in
                do {
                    if let data = data, let result = try UserDao.saveUser(json: data, with: context) {
                        callback(result)
                    }
                } catch {
                    // TODO: show msg in toast
                    print("Failed to save user.")
                    print(error.localizedDescription)
                }
            }, onFailure: {
                    // TODO: show msg in toast
                    print("Internal failure.")
                })
        } catch let ex {
            // TODO: show msg in toast
            print(ex.localizedDescription)
        }
    }
}
