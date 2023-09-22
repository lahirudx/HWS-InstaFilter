//
//  ContentView.swift
//  InstaFilter
//
//  Created by Lahiru Amarasooriya on 2023-09-09.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showPhotoPicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button {
                showPhotoPicker = true
            } label: {
                Text("Select image")
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }

                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
            
        }
        .padding()
        .sheet(isPresented: $showPhotoPicker, content: {
            ImagePicker(image: $inputImage)
        })
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
