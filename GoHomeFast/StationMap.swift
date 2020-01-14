//
//  StationMap.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/8.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI
import MapKit

struct StationMap: View {
    @Binding var latitude: Double
    @Binding var longitude: Double
    var body: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            .frame(height: 200)
    }
}

struct StationMap_Previews: PreviewProvider {
    static var previews: some View {
        StationMap(latitude: .constant(25.05318832397461), longitude: .constant(121.60706329345703))
    }
}
