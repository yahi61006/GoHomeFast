//
//  MyPlaceRow.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/14.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI

struct PhotoRow: View {
    var photo: Photo
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(contentsOfFile: photo.imagePath)!)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .padding()
            Text(photo.placename)
            Spacer()
            Text(dateFormatter.string(from: photo.gotoDate))
            Image(systemName: photo.favorite ? "heart.fill" : "heart")
        }
    }
}

struct PhotoRow_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRow(photo: Photo(placename: "台北101", gotoDate: Date(), favorite: true, imageName: "noPhoto"))
    }
}
