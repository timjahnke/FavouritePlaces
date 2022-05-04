//
//  MasterView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 3/5/2022.
//

import SwiftUI

struct MasterView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.id, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        List {
            ForEach(places, id: \.self.id) { place in
                NavigationLink(destination: DetailView(place: place)) {
                    HStack {
                        Image(systemName: "location.square").foregroundColor(.green)
                        Text(place.placeTitle)
                    }
                }
            }
            .onDelete(perform: deletePlaces)
        }
    }

 
    // Delete places from the list.
    private func deletePlaces(offsets: IndexSet) {
        withAnimation {
            // Return an array of retrieved places using the index set. Delete each NSObject from array.
            offsets.map { places[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
