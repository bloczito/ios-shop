import Combine
import SwiftUI
import RealmSwift


class GlobalState: ObservableObject {
    @Published var authToken: String?
    
    @Published var itemsNumber: Int
    @Published var errorMsg: String?
    @Published private(set) var successMsg: String?
    
    @Published private(set) var categories: [CategoryModel]
    @Published private(set) var products: [ProductModel]
    
//    @Published var cartItems: CartItemDto
//    @Published
    
    @Published var categoryId: UUID? {
        didSet {
            if let categoryId = categoryId {
                if categoryId != oldValue {
                    self.products = productRepo.getByCategoryId(categoryId)
                }
            }
        }
    }
    
    @Published var cartItems: [CartItemDto] = []
    
    var reloadCart = true
    
    private var realm: Realm
    let productRepo: ProductRepo
    
    func setSuccessMsg(msg: String) {
        withAnimation {
            self.successMsg = msg
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: clearSuccessMsg)
        }
    }
    
    private func clearSuccessMsg() {
//        withAnimation {
            self.successMsg = nil
//        }
    }
    
    func setErrorMsg(msg: String) {
        withAnimation {
            self.errorMsg = msg
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: clearErrorMsg)
        }
    }
    
    private func clearErrorMsg() {
//        withAnimation {
            self.errorMsg = nil
//        }
    }

    
    
    init(token: String?) {
        let db = PersistenceController.initialize()
        self.authToken = token
        self.itemsNumber = 0
        self.errorMsg = nil
        self.successMsg = nil
        self.categoryId = nil
        self.realm = db
        self.categories = CategoryRepo(realm: db).getAll()
        self.productRepo = ProductRepo(realm: db)
        self.products = []
        
        if let token = token {
            CartApi.countCartItems(userToken: token) { result in
                switch result {
                case .success(let number):
                    self.itemsNumber = number
                case .failure(let error):
                    self.setErrorMsg(msg: error.message)
                }
            }
            Loader().loadData()
        }
    }
}

