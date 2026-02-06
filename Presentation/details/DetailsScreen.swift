
import SwiftUI

struct DetailsScreen: View{
    private var moviewID: Int
    
    init(moviewID: Int) {
        self.moviewID = moviewID
    }
    var body: some View{
        Text("Details Screen for \(moviewID)")
    }
}
