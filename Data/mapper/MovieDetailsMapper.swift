
struct MovieDetailsMapper{
    static func map(_ dto: MovieDetailsResponseDTO) -> MovieDetails {
            MovieDetails(
                id: dto.id,
                title: dto.title,
                originalTitle:  dto.originalTitle,
                overview:  dto.overview ?? "",
                posterPath:  dto.posterPath,
                backdropPath:  dto.backdropPath,
                releaseDate:  dto.releaseDate,
                runtime:  dto.runtime,
                voteAverage:  dto.voteAverage ?? 0,
                voteCount:  dto.voteCount ?? 0,
                genres:  dto.genres.map {
                    MovieGenre(id: $0.id, name: $0.name)
                },
                productionCompanies:  dto.productionCompanies?.map {
                    MovieProductionCompany(
                        id: $0.id,
                        name: $0.name,
                        logoPath: $0.logoPath,
                        originCountry: $0.originCountry
                    )
                } ?? [],
                spokenLanguages: dto.spokenLanguages?.map {
                    MovieSpokenLanguage(
                        name: $0.name,
                        englishName: $0.englishName,
                        isoCode: $0.iso639_1
                    )
                } ?? [],
                status:  dto.status,
                tagline:  dto.tagline,
                homepage:  dto.homepage,
                imdbId:  dto.imdbId
        )
    }
}
