//
//  AllCategoriesResponse.swift
//  spotify-clone
//
//  Created by Chandru A S on 12/12/24.
//

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
