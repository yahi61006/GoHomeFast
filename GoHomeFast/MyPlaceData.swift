//
//  MyPlaceData.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/14.
//  Copyright © 2020 Kumo. All rights reserved.
//

import Foundation

class MyPlaceData: ObservableObject {
    @Published var places = [MyPlace](){
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(places) {
                UserDefaults.standard.set(data, forKey: "places")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "places") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([MyPlace].self, from: data) {
                places = decodedData
            }
        }
    }
}
