
import SwiftUI

struct MovieCardInfo: View {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? ""))) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(16)
                

                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                        .cornerRadius(16)


                @unknown default:
                    EmptyView()
                }
            }.padding(8)
            
            VStack(alignment: .leading, spacing: 4){
                Text(movie.title)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
                
                Text(movie.description ?? "")
                    .font(.system(size: 14, weight: .regular))
                    .lineLimit(3)
                
                if let releaseDate = movie.releaseDate {
                    Text(releaseDate)
                        .font(.system(size: 10, weight: .light))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            
            }.padding(EdgeInsets(top: 16, leading: 0 , bottom: 16, trailing: 16))
            
        
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 2)
    }
}
