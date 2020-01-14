//
//  HSR_Row.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/7.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI

struct HSR_Row: View {
    var train: HSR
    let screenSize = UIScreen.main.bounds.size
    var body: some View {
        VStack {
            Text(train.TrainDate)
                .offset(x: 30, y: 0)
            HStack{
                Text(train.DailyTrainInfo.TrainNo)
                    .frame(width: 50, height: 20)
                    .padding(2)
                    .foregroundColor(Color.blue)
                    .background(Color.yellow)
                VStack {
                    Text(train.OriginStopTime.StationName.Zh_tw)
                        .font(.title)
                        .padding(10)
                    Text("離開時間")
                        .foregroundColor(Color.red)
                    Text(train.OriginStopTime.DepartureTime)
                    
                }
                Image(systemName: "arrow.right")
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                VStack{
                    Text(train.DestinationStopTime.StationName.Zh_tw)
                        .font(.title)
                        .padding(10)
                    Text("抵達時間")
                        .foregroundColor(Color.red)
                    Text(train.DestinationStopTime.ArrivalTime)
                }
            }
        }
    }
}

struct HSR_Row_Previews: PreviewProvider {
    static var previews: some View {
        HSR_Row(train: HSR(TrainDate: "2020-01-01", DailyTrainInfo: HSRNo(TrainNo: "1234"), OriginStopTime: HSRDepartureTime(DepartureTime: "12:01", StationName: StationName(Zh_tw: "南港")), DestinationStopTime: HSRArrivalTime(ArrivalTime: "13:30", StationName: StationName(Zh_tw: "嘉義"))))
    }
}
