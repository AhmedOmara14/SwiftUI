
public struct MovieDTO : Codable {
    var id: Int
    var title: String
    var overview: String?
    var releaseDate: String?
    var posterPath: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", overview = "overview", releaseDate = "release_date", posterPath = "poster_path"
    }
}
