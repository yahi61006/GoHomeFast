//
//  StationRow.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/8.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI

struct StationRow: View {
    var station: Station
    @State private var showMap = false
    @State private var latitude: Double = 25.05318832397461
    @State private var longitude: Double = 121.60706329345703
    var body: some View {
        HStack {
            LottieView(filename: "110-location")
                .frame(width: 80, height: 80)
                .padding()
            VStack {
                Text(station.StationName.Zh_tw)
                    .font(.headline)
                Text("show map")
                    .foregroundColor(Color.blue)
                    .onTapGesture{
                        self.showMap = true
                        self.latitude = self.station.StationPosition.PositionLat
                        self.longitude = self.station.StationPosition.PositionLon
                }
                .sheet(isPresented: self.$showMap) {
                    StationMap(latitude: self.$latitude, longitude: self.$longitude)
                }
            }
        }
    }
}

struct StationRow_Previews: PreviewProvider {
    static var previews: some View {
        StationRow(station: Station(StationID: "1000", StationName: StationName(Zh_tw: "台北"), StationPosition: Position(PositionLat: 25.047670364379883, PositionLon: 121.51698303222656)))
    }
}
