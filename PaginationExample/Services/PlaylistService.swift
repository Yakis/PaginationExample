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
    func getOneBatch(nextPageToken: String?, completion: (ResponseExample?, Error?) -> ()) {
        googleServer.serverAPI(token: nextPageToken, completion: completion)
    }
    
    
}
