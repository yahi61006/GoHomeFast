//
//  SelectStation.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/14.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI

struct SelectStation: View {
    @State private var stations = [Station]()
    @State private var departstation = "南港"
    @State private var arrivestation = "嘉義"
    @State private var showHSR = false
    @State private var traveldate = Date()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.string(from: Date())
        return dateFormatter
    }()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Text("起站")
                            .frame(width: 50, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.pink, lineWidth: 5))
                            .padding()
                        NavigationLink(destination: StationList()) {
                            Text(departstation)
                                .frame(width: 120, height: 120)
                                .padding(10)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(30)
                        }
                    }
                    Image(systemName: "arrow.right.arrow.left")
                        .frame(width: 60, height: 200)
                        .offset(x: 0, y: 30)
                        .onTapGesture {
                            (self.departstation, self.arrivestation) = (self.arrivestation, self.departstation)
                    }
                    VStack {
                        Text("迄站")
                            .frame(width: 50, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.pink, lineWidth: 5))
                            .padding()
                        NavigationLink(destination: StationList()) {
                            Text(arrivestation)
                                .frame(width: 120, height: 120)
                                .padding(10)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(30)
                        }
                    }
                }
                Text("查詢日期")
                DatePicker("日期", selection: $traveldate, in: ...Date(), displayedComponents: .date)
                    .frame(width: 300, height: 150)
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                Text(dateFormatter.string(from: traveldate))
                    .padding(50)
                
                Button(action: {self.showHSR = true}){
                    Text("查詢結果")
                        .frame(width: 100, height: 50)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.purple)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                }.sheet(isPresented: self.$showHSR) {
                    HSRList(traveldate: self.$traveldate)
                }
                
            }
            .navigationBarTitle("高鐵時刻表查詢")
        }
    }
}

struct SelectStation_Previews: PreviewProvider {
    static var previews: some View {
        SelectStation()
    }
}
