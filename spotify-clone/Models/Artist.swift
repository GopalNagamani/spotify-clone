//
//  Artist.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import Foundation


struct Artist: Codable {
    let name: String
    let id: String
    let type: String
    let external_urls: [String: String]
}
