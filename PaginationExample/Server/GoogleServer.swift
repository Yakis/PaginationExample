//
//  GoogleServer.swift
//  PaginationExample
//
//  Created by Mugurel Moscaliuc on 10/05/2021.
//

import Foundation


// Similar to your model
struct ResponseExample {
    
    var id: UUID
    var items: [Int]
    var nextPageToken: String?
    
}


// This is just a hardcoded simulated backend
class GoogleServer: NSObject {
    
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8]
    
    
    func serverAPI(token: String?, completion: (ResponseExample?, Error?) -> ()) {
        print("SERVER SIDE: \(String(describing: token))")
        if let token = token {
            completion(ResponseExample(id: UUID(), items: data(for: token), nextPageToken: getNextToken(currentToken: token)), nil)
        } else {
            completion(ResponseExample(id: UUID(), items: Array(numbers[0...1]), nextPageToken: "second"), nil)
        }
    }
    
    
    
    func data(for token: String) -> [Int] {
        switch token {
        case "second": return Array(numbers[2...3])
        case "third": return Array(numbers[4...5])
        default: return Array(numbers[6...7])
        }
    }
    
    
    func getNextToken(currentToken: String) -> String? {
        if currentToken == "first" {
            return "second"
        } else if currentToken == "second" {
            return "third"
        } else if currentToken == "third" {
            return "fourth"
        } else {
            return nil
        }
    }
    
}
