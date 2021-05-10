//
//  ContentView.swift
//  PaginationExample
//
//  Created by Mugurel Moscaliuc on 10/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var playlistVM = PlaylistVM()
    
    var body: some View {
        Text(playlistVM.numbers.isEmpty ? "Hello, world!" : "\(playlistVM.numbers.count) items")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
