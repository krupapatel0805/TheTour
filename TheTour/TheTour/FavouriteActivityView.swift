//
//  FavoriteActivitiesView.swift
//  TheTour
//
//  Created by Sam 77 on 2023-06-12.
//

import SwiftUI

struct FavoriteActivitiesView: View {
    @State private var favoriteActivities: [Activity] = []
    
    var body: some View {
        VStack {
            if favoriteActivities.isEmpty {
                Text("No favorite activities yet.")
                    .foregroundColor(.gray)
                    .font(.title)
                    .padding()
            } else {
                List {
                    ForEach(favoriteActivities) { activity in
                        NavigationLink(destination: ActivityDetailsView(activity: activity)) {
                            VStack(alignment: .leading) {
                                activity.photo
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                
                                Text(activity.name)
                                    .font(.headline)
                                
                                Text("Price per person: $" + String(format: "%.2f", activity.pricePerPerson))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteFavoriteActivity)
                }
            }
        }
        .navigationTitle("Favorite Activities")
        .onAppear {
            loadFavoriteActivities()
        }
    }
    
    func loadFavoriteActivities() {
        let favoriteActivityNames = UserDefaults.standard.array(forKey: "FavoriteActivities") as? [String] ?? []
        favoriteActivities = ActivityData().activities.filter { favoriteActivityNames.contains($0.name) }
    }
    
    func deleteFavoriteActivity(at offsets: IndexSet) {
        favoriteActivities.remove(atOffsets: offsets)
        
        // Update the favorites list in UserDefaults
        let favoriteActivityNames = favoriteActivities.map { $0.name }
        UserDefaults.standard.set(favoriteActivityNames, forKey: "FavoriteActivities")
    }
}
