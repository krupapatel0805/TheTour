//
//  ActivityDetailsView.swift
//  TheTour
//
//  Created by Sam 77 on 2023-06-10.
//

import SwiftUI

struct ActivityDetailsView: View {
    let activity: Activity
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text(activity.name)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            VStack {
                activity.photo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("Rating: \(activity.starRating)/5")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.top, 8)
                
                Text(activity.description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                Text("Hosted by: \(activity.host)")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.top, 4)
            }
            .padding(.vertical)
            
            Text("Price per person: $\(String(format: "%.2f", activity.pricePerPerson))")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            HStack {
                Button(action: {
                    callHostPhoneNumber(activity.hostPhoneNumber)
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                        
                        Text("Call Host: \(activity.hostPhoneNumber)")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                }
                .padding()
                
                Button(action: {
                    shareActivity(activity)
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .padding()
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            isFavorite = isActivityFavorite(activity)
        }
    }
    
    func callHostPhoneNumber(_ phoneNumber: String) {
        if let phoneURL = URL(string: "tel:\(phoneNumber)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
        
        // Update the favorites list in UserDefaults
        var favoriteActivities = UserDefaults.standard.array(forKey: "FavoriteActivities") as? [String] ?? []
        
        if isFavorite {
            // Add activity to favorites
            favoriteActivities.append(activity.name)
        } else {
            // Remove activity from favorites
            favoriteActivities.removeAll { $0 == activity.name }
        }
        
        UserDefaults.standard.set(favoriteActivities, forKey: "FavoriteActivities")
    }
    
    func shareActivity(_ activity: Activity) {
        let activityInfo = "Check out this activity: \(activity.name)\nPrice: $\(String(format: "%.2f", activity.pricePerPerson))\nDescription: \(activity.description)"
        
        let activityItems: [Any] = [activityInfo]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            activityViewController.popoverPresentationController?.sourceView = rootViewController.view
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: rootViewController.view.bounds.midX, y: rootViewController.view.bounds.midY, width: 0, height: 0)
            activityViewController.popoverPresentationController?.permittedArrowDirections = []
            
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func isActivityFavorite(_ activity: Activity) -> Bool {
        let favoriteActivities = UserDefaults.standard.array(forKey: "FavoriteActivities") as? [String] ?? []
        return favoriteActivities.contains(activity.name)
    }
}

    
    func isActivityFavorite(_ activity: Activity) -> Bool {
        let favoriteActivities = UserDefaults.standard.array(forKey: "FavoriteActivities") as? [String] ?? []
        return favoriteActivities.contains(activity.name)
    }
