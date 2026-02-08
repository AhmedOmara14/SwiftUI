
import Foundation

struct MovieDetails: Identifiable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let runtime: Int?
    let voteAverage: Double?
    let voteCount: Int
    let genres: [MovieGenre]?
    let productionCompanies: [MovieProductionCompany]
    let spokenLanguages: [MovieSpokenLanguage]
    let status: String?
    let tagline: String?
    let homepage: String?
    let imdbId: String?
    
    
}

struct MovieGenre: Identifiable {
    let id: Int
    let name: String
}

struct MovieProductionCompany: Identifiable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: String?
}

struct MovieSpokenLanguage: Identifiable {
    let id = UUID()   
    let name: String
    let englishName: String
    let isoCode: String
}
