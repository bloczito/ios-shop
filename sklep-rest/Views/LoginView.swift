import SwiftUI
import Auth0
import Security

struct LoginView: View {
    
    @EnvironmentObject var globalState: GlobalState
    
    var body: some View {
        VStack(spacing: 100) {
            Image("store-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.horizontal)
                
            
            Button(action: handleLogin) {
                Text("Zaloguj")
            }
            .tint(.black)
            .buttonStyle(.borderedProminent)
            .font(.system(size: 25, weight: .bold))
        
        }
    }
    
    func handleLogin() {
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://dev-p-th9prq.us.auth0.com/userinfo")
            .start { result in
                switch result {
                case .failure(let error):
                    print("LOGGING FAILED. Error: \(error)")
                case .success(let credentials):
                    if let token = credentials.accessToken {
                        
                        TokenHandler.saveToken(token, expirationDate: credentials.expiresIn!)
                        Loader().loadData()
                        self.globalState.authToken = token
                        
                        CartApi.countCartItems(userToken: token) { result in
                            switch result {
                            case .success(let number):
                                self.globalState.itemsNumber = number
                            case .failure(let err):
                                self.globalState.setErrorMsg(msg: err.message)
                            }
                        }
                        
                    }
                    
                }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
