//
//  PlaylistVM.swift
//  PaginationExample
//
//  Created by Mugurel Moscaliuc on 10/05/2021.
//

import Foundation


enum HTTPError: String, Error {
    case invalidData = "Invalid data from server"
    case decodingError = "Error decoding JSON"
}


class PlaylistVM: ObservableObject {
    
    var numbers: [Int] = []
    let playlistService = PlaylistService()
    
    
    init() {
        getAllData { result in
            switch result {
            case .success(let numbers):
                print("Numbers received!", numbers)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getAllData(completion: @escaping(Result<[Int], HTTPError>) -> ()) {
        var isFirstRequest = true
        var token: String? = nil
        let group = DispatchGroup()
        if isFirstRequest {
            group.enter()
            playlistService.getOneBatch(nextPageToken: token) { result in
                switch result {
                case .failure(let error): print(error)
                case .success(let response):
                    isFirstRequest = false
                    token = response.nextPageToken
                    self.numbers.append(contentsOf: response.items)
                    print("Received: \(String(describing: response.items)), nextPageToken: \(String(describing: token))")
                    group.leave()
                    while !isFirstRequest && token != nil {
                        group.enter()
                        self.playlistService.getOneBatch(nextPageToken: token) { result in
                            switch result {
                            case .failure(let error): print(error)
                            case .success(let response):
                                token = response.nextPageToken
                                self.numbers.append(contentsOf: response.items)
                                print("Received: \(String(describing: response.items)), nextPageToken: \(String(describing: token))")
                                group.leave()
                            }
                        }
                        group.wait()
                    }
                    group.notify(queue: DispatchQueue.global()) { [unowned self] in
                        completion(.success(self.numbers))
                    }
                }
            }
        }
    }
    
    
}
