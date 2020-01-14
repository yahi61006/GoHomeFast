//
//  StationList.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/8.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI
import CryptoKit

struct StationList: View {
    @State private var stations = [Station]()
    
    func getTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let time = dateFormatter.string(from: Date())
        return time
    }
    
    func fetchStation(){
        let query = "https://ptx.transportdata.tw/MOTC/v2/Rail/THSR/Station?$top=30&$format=JSON"
        if let urlStr = query.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed){
            if let url = URL(string: urlStr) {
                let appID = "70364fea623043a2980f280422c8e7f2"
                let appKey = "1aO1AxsSI5WlRSylSOCZuAQOIHA"
                let xdate = getTimeString()
                let signDate = "x-date: \(xdate)"
                let key = SymmetricKey(data: Data(appKey.utf8))
                let hmac = HMAC<SHA256>.authenticationCode(for: Data(signDate.utf8), using: key)
                let base64HmacString = Data(hmac).base64EncodedString()
                let authorization = """
                hmac username="\(appID)", algorithm="hmac-sha256", headers="x-date", signature="\(base64HmacString)"
                """
                var request = URLRequest(url: url)
                request.setValue(xdate, forHTTPHeaderField: "x-date")
                request.setValue(authorization, forHTTPHeaderField: "Authorization")
                request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")//減少傳輸量
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    let decoder = JSONDecoder()
                    if let data = data, let stationResults = try? decoder.decode([Station].self, from: data) {
                        self.stations = stationResults
                    }
                    else{
                        print("error")
                    }
                }.resume()
            }
        }
        
    }
    
    var body: some View {
        NavigationView {
            List(stations.indices, id: \.self) { (index)  in
                StationRow(station: self.stations[index])
            }
            .onAppear {
                self.fetchStation()
            }
        .navigationBarTitle("高鐵車站")
        }
    }
}

struct StationList_Previews: PreviewProvider {
    static var previews: some View {
        StationList()
    }
}
