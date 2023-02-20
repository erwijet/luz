//
//  LuzServer.swift
//  luz
//
//  Created by Tyler Holewinski on 2/19/23.
//

import Foundation

class LuzServer {
    static let shared = LuzServer();
    private init() {}
    
    enum LightMode {
        case on, off
    }
    
    func turnLights(_ mode: LightMode) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pisces-lights-server.at.remote.it"
        urlComponents.port = 33000
        urlComponents.path = mode == .on ? "/on" : "/off"
        
        let url = urlComponents.url!
        
        var req = URLRequest(url: url)
        req.timeoutInterval = 500
        
        req.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: req) { data, res, err in
            guard
                let data = data,
                let res = res as? HTTPURLResponse,
                err == nil
            else {
                print("error", err ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= res.statusCode else {
                print("status code should be in 200 series, but got \(res.statusCode)")
                return
            }
            
            print("ok")
        }
        
        task.resume()
    }
}
