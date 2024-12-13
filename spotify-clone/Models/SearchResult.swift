//
//  SearchResult.swift
//  spotify-clone
//
//  Created by Chandru A S on 14/12/24.
//

import Foundation

enum SearchResult {
    case artists(model: Artist)
    case albums(model: Album)
    case playlists(model: Playlist)
    case tracks(model: AudioTrack)
}
