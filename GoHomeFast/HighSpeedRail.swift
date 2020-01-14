//
//  HighSpeedRail.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/7.
//  Copyright © 2020 Kumo. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct HSR: Codable {
    var TrainDate: String
    var DailyTrainInfo: HSRNo
    var OriginStopTime: HSRDepartureTime
    var DestinationStopTime: HSRArrivalTime
}

struct HSRNo: Codable {
    var TrainNo: String
}

struct HSRDepartureTime: Codable {
    var DepartureTime: String
    var StationName: StationName
}

struct HSRArrivalTime: Codable {
    var ArrivalTime: String
    var StationName: StationName
}

struct Station: Codable {
    var StationID: String
    var StationName: StationName
    var StationPosition: Position
}

struct StationName: Codable {
    var Zh_tw: String
}

struct Position: Codable {
    var PositionLat: Double
    var PositionLon: Double
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        uiView.setRegion(region, animated: true)
    }
}


