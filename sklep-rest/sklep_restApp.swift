import SwiftUI
import RealmSwift

//uj.sklep-bloczke://dev-p-th9prq.us.auth0.com/ios/uj.sklep-bloczke/callback
//uj.sklep-bloczke://dev-p-th9prq.us.auth0.com/ios/uj.sklep-bloczke/callback

@main
struct sklep_restApp: SwiftUI.App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let realm: Realm
    
    @StateObject var globalState = GlobalState(token: TokenHandler.loadToken())
    
    init() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        realm = PersistenceController.initialize()
    }
    
    var body: some Scene {
        WindowGroup {
            
            if globalState.authToken != nil {
                MainView()
                    .environmentObject(CategoryRepo(realm: realm))
                    .environmentObject(ProductRepo(realm: realm))
                    .environmentObject(ShopRepo(realm: realm))
                    .environmentObject(globalState)
            } else {
                LoginView()
                    .environmentObject(globalState)
            }
            
            
        }
    }
}

