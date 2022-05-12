//
//  ImageView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 5/5/2022.
//

import SwiftUI
import Combine
import CoreData

// Create a struct view for DetailView images
struct Master_ImageView: View {
    // Accepts instance of class Place to observe.
    @ObservedObject var place: Place
    
    // Create a UI Image
    var image: UIImage {
        // Use guard to perform code and return/exit to fatalError if cannot execute code.
        guard
            // Convert Place attribute from string to URL type.
            let url = URL(string: place.placeUrl),
            //  Attempt to get contents of the URL as data.
            let data = try? Data(contentsOf: url),
            // Use data to create a UI Image to return
            let nsImage = UIImage(data: data)
        else {
            fatalError("Error on using image url")
        }
        return nsImage
    }
    
    // Create a view that renders the above nsImage. Image is resizable and scalable. Frame is used to set fixed dimensions. 
    var body: some View {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40);
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
