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

    var body: some View {
        NavigationView {
            MasterView()
            .navigationTitle("Favourite Places")
        }
        .navigationViewStyle(.stack)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
