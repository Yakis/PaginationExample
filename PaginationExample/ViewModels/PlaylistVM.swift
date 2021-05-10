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
    
    
    func getAllData(completion: ([Int]?, Error?) -> ()) {
        var isFirstRequest = true
        var token: String? = nil
        if isFirstRequest {
            playlistService.getOneBatch(nextPageToken: token) { response, error in
                isFirstRequest = false
                token = response?.nextPageToken
                numbers.append(contentsOf: response!.items)
                print("Received: \(String(describing: response?.items)), nextPageToken: \(String(describing: token))")
                while !isFirstRequest && token != nil {
                    playlistService.getOneBatch(nextPageToken: token) { response, error in
                        token = response?.nextPageToken
                        numbers.append(contentsOf: response!.items)
                        print("Received: \(String(describing: response?.items)), nextPageToken: \(String(describing: token))")
                    }
                }
                completion(numbers, nil)
            }
        }
    }
    
    
}
