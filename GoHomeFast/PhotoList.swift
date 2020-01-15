//
//  MyPlaceList.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/14.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI

struct PhotoList: View {
    @EnvironmentObject var photoData: PhotoData
    @State private var showPhotoEdit = false
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(photoData.photos.indices, id:\.self){ (index) in
                    PhotoRow(photo: self.photoData.photos[index])
                        .contextMenu {
                            Button(action: {self.photoData.photos.remove(at: index)}) {
                                HStack{
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                            Button(action: {self.photoData.photos[index].favorite.toggle()}) {
                                HStack{
                                    Text("最愛")
                                    Image(systemName: "heart")
                                }
                            }
                    }
                    
                }
            }
            .navigationBarTitle("我的旅遊地點")
            .navigationBarItems(leading: Image("nophoto")
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 45)
            .clipped()
                , trailing: Button(action: {
                    self.showPhotoEdit = true
                }, label: {
                    Image(systemName: "folder.badge.plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width:30, height:30)
                }))
                .sheet(isPresented: $showPhotoEdit) {
                    NavigationView {
                        PhotoEdit().environmentObject(self.photoData)
                    }
            }
        }
    }
}


struct PhotoList_Previews: PreviewProvider {
    static var previews: some View {
        PhotoList().environmentObject(PhotoData())
    }
}
