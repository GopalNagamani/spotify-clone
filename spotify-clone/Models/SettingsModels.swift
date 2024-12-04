//
//  SettingsModels.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import Foundation


struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
