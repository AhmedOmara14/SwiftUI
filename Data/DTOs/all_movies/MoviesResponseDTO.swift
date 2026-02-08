
public struct MoviesResponseDTO: Codable {
    let results: [MovieDTO]
    let page : Int
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results = "results", page = "page", totalPages = "total_pages", totalResults = "total_results"
    }
}
