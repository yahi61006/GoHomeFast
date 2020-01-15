//
//  ContentView.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/6.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var photoData: PhotoData
    var body: some View {
        TabView{
            SelectStation()
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("選擇車站")
            }
            PhotoList()
                .tabItem {
                    Image(systemName: "hare.fill")
                    Text("旅遊地點")
            }
            Author()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("作者")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
