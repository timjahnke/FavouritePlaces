//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 2/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.id, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        NavigationView {
            List {
                ForEach(places) { place in
//                    NavigationLink {
                    Text(place.name ?? "")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
                }
                .onDelete(perform: deletePlaces)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement:
                .navigationBarTrailing) {
                    Button {
                        addPlace()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
//            Text("Select an item")
        }
    }

    private func addPlace() {
        withAnimation {
            let newPlace = Place(context: viewContext)
            newPlace.name = "New Place"
            newPlace.location = ""
            newPlace.image = ""

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

    private func deletePlaces(offsets: IndexSet) {
        withAnimation {
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

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
