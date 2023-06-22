//
//  Activity.swift
//  TheTour
//
//  Created by Sam 77 on 2023-06-08.
//

import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    let name: String
    let pricePerPerson: Double
    let imageName: String
    let description: String
    let host: String
    let hostPhoneNumber: String
    let starRating: Int
    let photo: Image

    init(name: String, pricePerPerson: Double, imageName: String, description: String, host: String, hostPhoneNumber: String, starRating: Int, photo: Image) {
        self.name = name
        self.pricePerPerson = pricePerPerson
        self.imageName = imageName
        self.description = description
        self.host = host
        self.hostPhoneNumber = hostPhoneNumber
        self.starRating = starRating
        self.photo = photo
    }
}
