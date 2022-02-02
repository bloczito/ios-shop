import Foundation


final class CartApi {
    private static let baseURL = "http://localhost:8080/cartItems"
    
    static func getCartItems(userToken: String, completion: @escaping (Result<[CartItemDto], ApiError>) -> ()) {
        guard let url = URL(string: "\(CartApi.baseURL)") else {
            completion(.failure(ApiError("Bad URL")))
            return
        }
        
        var req = URLRequest(url: url)
        req.allHTTPHeaderFields = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(userToken)"
        ]
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
      
        
        session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(ApiError(error.localizedDescription)))
            }
            
            let items = try! JSONDecoder().decode([CartItemDto].self, from: data!)
            
            
//            DispatchQueue.main.async {
                completion(.success(items))
//            }
        
        }.resume()
        
    }

    
    static func countCartItems(userToken: String, completion: @escaping (Result<Int, ApiError>) -> ()) {
        let url = URL(string: "\(CartApi.baseURL)/count")!

        var req = URLRequest(url: url)
        req.allHTTPHeaderFields = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(userToken)"
        ]
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let dispatchGroup = DispatchGroup()
        
        let task = session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(ApiError(error.localizedDescription)))
            }
            
             let number = try! JSONDecoder().decode(Int.self, from: data!)
            
            
            completion(.success(number))
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
    }
    
    
    static func addCartItem(token: String, data: AddRemoveItemDto, completion: @escaping (Result<Int, ApiError>) -> ()) {
        guard let url = URL(string: "\(CartApi.baseURL)") else {
            completion(.failure(ApiError("Bad URL")))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.httpBody = try! JSONEncoder().encode(data)
        req.allHTTPHeaderFields = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(token)"
        ]
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(ApiError(error.localizedDescription)))
            }
            
            let number = try! JSONDecoder().decode(Int.self, from: data!)
            
            DispatchQueue.main.async {
                completion(.success(number))
            }
        }.resume()
    }
    
    static func reduceCartItem(token: String, data: AddRemoveItemDto, completion: @escaping (Result<Int, ApiError>) -> ()) {
        guard let url = URL(string: "\(CartApi.baseURL)") else {
            completion(.failure(ApiError("Bad URL")))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.httpBody = try! JSONEncoder().encode(data)
        req.allHTTPHeaderFields = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(token)"
        ]
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(ApiError(error.localizedDescription)))
            }
            
            let number = try! JSONDecoder().decode(Int.self, from: data!)
            
            DispatchQueue.main.async {
                completion(.success(number))
            }
        }.resume()
    }
    
    
    static func deleteCartItem(token: String, productId: UUID, completion: @escaping (Result<Void, ApiError>) -> ()) {
        guard let url = URL(string: "\(CartApi.baseURL)/\(productId)") else {
            completion(.failure(ApiError("Bad URL")))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "DELETE"
        req.allHTTPHeaderFields = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(token)"
        ]
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(ApiError(error.localizedDescription)))
            }
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }.resume()
    }
    
    
}
