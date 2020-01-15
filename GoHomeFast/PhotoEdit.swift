//
//  MyPlaceEdit.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/14.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI

struct PhotoEdit: View {
    @EnvironmentObject var photoData: PhotoData
    @Environment(\.presentationMode) var presentationMode
    @State private var placename = ""
    @State private var gotoDate = Date()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    @State private var favorite = false
    @State private var imagepath = ""
    @State private var showSelectPhoto = false
    @State private var selectImage: UIImage?
    @State private var scale: CGFloat = 1
    @State private var newscale: CGFloat = 1
    //var photoData: PhotoData
    var editphoto: Photo?
    
    var body: some View {
        Form {
            Button(action: {
                self.showSelectPhoto = true
            }) {
                Group {
                    if selectImage != nil {
                        Image(uiImage: selectImage!)
                            .resizable()
                            .renderingMode(.original)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                    }
                }
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipped()
                .scaleEffect(scale)
                .gesture(MagnificationGesture()
                .onChanged { value in
                    self.scale = self.newscale * value.magnitude
                }.onEnded { value in
                    self.newscale = self.scale
                })
            }
            
            /*Image(uiImage: UIImage(contentsOfFile: self.imagepath)!)
             .resizable()
             .scaledToFill()
             .frame(width: 200, height: 200)
             .clipped()*/
            
            
            TextField("地點", text: $placename)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.green, lineWidth: 2))
            
            Toggle("最愛", isOn: $favorite)
            
            VStack {
                DatePicker("日期", selection: $gotoDate, displayedComponents: .date)
                Text(dateFormatter.string(from: gotoDate))
            }
            .navigationBarTitle("新增地點")
            .navigationBarItems(trailing: Button("Save"){
                if self.selectImage != nil {
                    let imageName = UUID().uuidString
                    let url = PhotoData.documentsDirectory.appendingPathComponent(imageName)
                    try? self.selectImage?.jpegData(compressionQuality: 0.9)?.write(to: url)
                    let photo = Photo(placename: self.placename, gotoDate: self.gotoDate, favorite: self.favorite, imageName: imageName)
                    //self.selectImage = nil
                    if let editphoto = self.editphoto {
                        let index = self.photoData.photos.firstIndex {
                            $0.id == editphoto.id
                            }!
                        self.photoData.photos[index] = photo
                    }
                    else{
                        self.photoData.photos.insert(photo, at: 0)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
            
        }
        .sheet(isPresented: $showSelectPhoto) {
            ImagePickerController(selectImage: self.$selectImage, showSelectPhoto: self.$showSelectPhoto)
        }
    }
}

struct PhotoEdit_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEdit()
    }
}
