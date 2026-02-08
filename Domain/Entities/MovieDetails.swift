//
//  MovieDetails.swift
//  UserPosts
//
//  Created by Omara on 08/02/2026.
//


import Foundation

// MARK: - Domain Model
struct MovieDetails: Identifiable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let runtime: Int?
    let voteAverage: Double
    let voteCount: Int
    let genres: [MovieGenre]
    let productionCompanies: [MovieProductionCompany]
    let spokenLanguages: [MovieSpokenLanguage]
    let status: String?
    let tagline: String?
    let homepage: String?
    let imdbId: String?
}
