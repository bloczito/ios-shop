import Foundation


class ProductApi {
    func getProducts(categoryId: String, completion: @escaping ([ProductModel]) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8080/produkt?categoryId=\(categoryId)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let products = try! JSONDecoder().decode([ProductModel].self, from: data!)
            
            DispatchQueue.main.async {
                completion(products)
            }
        }
        .resume()
    }
}
