import SwiftUI
import RealmSwift
import Auth0
import Security

struct MainView: View {
    @EnvironmentObject var globalState: GlobalState

    var body: some View {
        ZStack {
            VStack {
                TabView {
                    CategoriesView()
                        .tabItem {
                            Label("Kategorie", systemImage: "list.dash")
                                .tint(.black)
                        }
                    CartView()
                        .tabItem {
                            Label("Koszyk", systemImage: "cart")
                        }
                        .badge(Int(globalState.itemsNumber))
                    AboutView()
                        .tabItem {
                            Label("O nas", systemImage: "house")
                        }
                }
                .tint(.black)
                .accentColor(.black)
            }
            
            if let msg = globalState.successMsg {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.green)
                        .opacity(0.9)
                        .overlay {
                            HStack {
                                Image(systemName: "checkmark.circle")
                                
                                Text (msg)
                            }
                        }
                        .transition(.opacity)
                        .frame(width: 200, height: 40)
                        .padding()
                        
                        
                    Spacer()
                }
            }
            
            if let msg = globalState.errorMsg {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                        .opacity(0.8)
                        .overlay {
                            HStack {
                                Image(systemName: "x.circle")
                                
                                Text (msg)
                            }
                        }
                        .transition(.opacity)
                        .frame(width: 200, height: 40)
                        .padding()
                        
                        
                    Spacer()
                }
            }
        }
        
    }
    
    func handleLogout() {
        
    }
}



struct MainView_Previews: PreviewProvider {
    let realm = try! Realm()
    
    static var previews: some View {
        MainView()
            .environmentObject(CategoryRepo(realm:try!  Realm()))
            .environmentObject(ProductRepo(realm: try! Realm()))
            .environmentObject(ShopRepo(realm: try! Realm()))
            .environmentObject(GlobalState(token: "sjdkasd"))
    }
}
