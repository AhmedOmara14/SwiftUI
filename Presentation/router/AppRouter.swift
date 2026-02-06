
import SwiftUI

class AppRouter : ObservableObject{
    @Published var path = NavigationPath()

    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
