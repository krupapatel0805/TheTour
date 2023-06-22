//
//  ActivityData.swift
//  TheTour
//
//  Created by Sam 77 on 2023-06-08.
//

import SwiftUI

struct ActivityData: View {
    let activities: [Activity] = [
        Activity(name: "Hiking", pricePerPerson: 25.0, imageName: "hiking", description: "Enjoy a scenic hike through the mountains.", host: "The Hiking Company", hostPhoneNumber: "1234567890", starRating: 4, photo: Image("hiking")),
        Activity(name: "City Tour", pricePerPerson: 30.0, imageName: "citytour", description: "Explore the city's landmarks and attractions with a knowledgeable guide.", host: "City Tours Inc.", hostPhoneNumber: "0987654321", starRating: 5, photo: Image("citytour")),
        Activity(name: "City Cruise", pricePerPerson: 40.0, imageName: "citycriuse", description: "Take a relaxing cruise along the city's waterfront.", host: "City Cruises Ltd.", hostPhoneNumber: "9876543210", starRating: 3, photo: Image("citycriuse")),
        Activity(name: "Cycling", pricePerPerson: 20.0, imageName: "cycling", description: "Go on a thrilling cycling adventure through scenic trails.", host: "Cycle Adventures", hostPhoneNumber: "0123456789", starRating: 4, photo: Image("cycling")),
        Activity(name: "Sightseeing", pricePerPerson: 35.0, imageName: "sightseeing", description: "Discover the city's famous landmarks and hidden gems.", host: "Sightseeing Tours Co.", hostPhoneNumber: "6789054321", starRating: 5, photo: Image("sightseeing"))
    ]
    
    @State private var isLoggedIn: Bool = true
    @State private var shouldNavigateToActivityData: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(activities) { activity in
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
            }
            .navigationBarTitle(isLoggedIn ? "Activities" : "", displayMode: .inline)
            .navigationBarItems(
                trailing: HStack {
                    NavigationLink(destination: FavoriteActivitiesView()) {
                        Image(systemName: "heart.fill")
                    }
                    
                    Button(action: {
                        // Perform logout action
                        isLoggedIn = false
                        shouldNavigateToActivityData = true
                    }) {
                        Image(systemName: "person.crop.circle.badge")
                    }
                }
            )
            .background(
                NavigationLink(destination: ContentView(), isActive: $shouldNavigateToActivityData) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}
