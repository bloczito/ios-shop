import SwiftUI

struct CategoriesView: View {
//    @EnvironmentObject var categoryRepo: CategoryRepo
    @EnvironmentObject var globalState: GlobalState
    
    var body: some View {
        NavigationView {
            List(globalState.categories) {
                NavigationLink($0.title, destination: ProductView(category: $0))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: handleLogout) {
                        Image(systemName: "person.crop.circle.badge.minus")
                    }
                }
            }
            .navigationTitle("Wybierz kategorię")
        }
    }
    
    func handleLogout() {
        TokenHandler.removeToken()
        globalState.authToken = nil
        
    }
}

//struct CategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
////        CategoriesView()
//    }
//}
