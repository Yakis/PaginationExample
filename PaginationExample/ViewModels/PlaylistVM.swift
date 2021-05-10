//
//  PlaylistVM.swift
//  PaginationExample
//
//  Created by Mugurel Moscaliuc on 10/05/2021.
//

import Foundation

class PlaylistVM: ObservableObject {
    
    var numbers: [Int] = []
    let playlistService = PlaylistService()
    
    
    init() {
        getAllData { numbers, error in
            print("Finished: \(String(describing: numbers))")
        }
    }
    
    
    func getAllData(completion: @escaping([Int]?, Error?) -> ()) {
        var isFirstRequest = true
        var token: String? = nil
        let group = DispatchGroup()
        if isFirstRequest {
            group.enter()
            playlistService.getOneBatch(nextPageToken: token) { response, error in
                isFirstRequest = false
                token = response?.nextPageToken
                self.numbers.append(contentsOf: response!.items)
                print("Received: \(String(describing: response?.items)), nextPageToken: \(String(describing: token))")
                group.leave()
                while !isFirstRequest && token != nil {
                    group.enter()
                    self.playlistService.getOneBatch(nextPageToken: token) { response, error in
                        token = response?.nextPageToken
                        self.numbers.append(contentsOf: response!.items)
                        print("Received: \(String(describing: response?.items)), nextPageToken: \(String(describing: token))")
                        group.leave()
                    }
                    group.wait()
                }
                group.notify(queue: DispatchQueue.global()) {
                    completion(self.numbers, nil)
                }
            }
        }
    }
    
    
}
