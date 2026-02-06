
struct MovieMapper {
    static func map(_ dto: MovieDTO) -> Movie {
        Movie(id: dto.id, title: dto.title, description: dto.overview, releaseDate: dto.releaseDate, posterPath: dto.posterPath)
    }
}
