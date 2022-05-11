//
//  ImageView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 5/5/2022.
//

import SwiftUI
import Combine
import CoreData

struct Master_ImageView: View {
    @ObservedObject var place: Place
    
    var image: UIImage {
        guard
            let url = URL(string: place.placeUrl),
            let data = try? Data(contentsOf: url),
            let nsImage = UIImage(data: data)
        else {
            fatalError("Error on using image url")
        }
        return nsImage
    }
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
