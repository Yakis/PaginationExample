//
//  PlaylistService.swift
//  PaginationExample
//
//  Created by Mugurel Moscaliuc on 10/05/2021.
//

import Foundation


class PlaylistService: NSObject {
    
    let googleServer = GoogleServer()
    
    // This is the basic request which will get you batches of data independent of your logic
    func getOneBatch(nextPageToken: String?, completion: @escaping(Result<ResponseExample, HTTPError>) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(900)) {
            self.googleServer.serverAPI(token: nextPageToken) { result in
                switch result {
                case .failure(let error): print(error)
                case .success(let data): completion(.success(data))
                }
            }
        }
    }
    
    
}
