//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 3/5/2022.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    
    var body: some View {
        // If Edit Mode is active
        if(editMode?.wrappedValue == .inactive) {
            List {
                Section(header:
                    Text(place.placeTitle)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .fontWeight(.bold)) {}
               
                    HStack{
                        Image(systemName: "location.square").foregroundColor(.green)
                    }
                    Text(place.placeDetails)
                    VStack {
                        HStack{
                            Text("Latitude:")
                            Text(place.placeLatitude)
                        }
                        
                        HStack{
                            Text("Longitude:")
                            Text(place.placeLongitude)
                        }
                    }
                }
            .toolbar {
                ToolbarItem(placement:
                .navigationBarTrailing) {
                   EditButton()
                }
            }
        }
        // If Edit Mode Is Active
        else if(editMode?.wrappedValue == .active) {
            List {
                TextField("Edit title", text: $place.placeTitle, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
                TextField("Edit place details", text: $place.placeDetails, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
                TextField("Edit image URL", text: $place.placeImage, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
                TextField("Edit place latitude", text: $place.placeLatitude, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
                TextField("Edit place longitude", text: $place.placeLongitude, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
            }
            .toolbar {
                ToolbarItem(placement:
                .navigationBarTrailing) {
                   EditButton()
                }
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
