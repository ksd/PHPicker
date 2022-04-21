//
//  ContentView.swift
//  PHPicker
//
//  Created by ksd on 20/04/2022.
//

import SwiftUI

struct ContentView: View {
  @State private var showPhotoSheet = false
  @State private var image: UIImage? = nil

  var body: some View {
    VStack {
      Button(action: { showPhotoSheet = true }) {
        Label("Choose photo", systemImage: "photo.fill")
      }
      .fullScreenCover(isPresented: $showPhotoSheet) {
        PhotoPicker(filter: .images, limit: 1) { results in
          PhotoPicker.convertToUIImageArray(fromResults: results) { (imagesOrNil, errorOrNil) in
            if let error = errorOrNil {
              print(error)
            }
            if let images = imagesOrNil {
              if let first = images.first {
                print(first)
                image = first
              }
            }
          }
        }
        .edgesIgnoringSafeArea(.all)
      }

      if let image = image {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: 200, maxHeight: 200)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
