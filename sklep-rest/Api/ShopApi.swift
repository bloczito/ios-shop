import Foundation


class ShopApi {
    func getShops(completion: @escaping ([ShopModel]) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8080/shop") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let categories = try! JSONDecoder().decode([ShopModel].self, from: data!)
            
            DispatchQueue.main.async {
                completion(categories)
            }
        }
        .resume()
    }
}
