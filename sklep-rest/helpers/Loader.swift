import Foundation
import RealmSwift

class Loader {
    
    func loadData() {
        loadCategoriesFromAPI()
        loadProductsFromAPI()
        loadShopsFromApi()
    }
    
    private func loadCategoriesFromAPI() {

        let serverURL = "http://127.0.0.1:8080/kategoria"

        let url = URL(string: serverURL)
        let request = URLRequest(url: url!)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let dispatchGroup = DispatchGroup()

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                print("Houston mamy problem")
                return
            }

            guard data != nil else {
                print("Nie ma danych")
                return
            }


            let categories = try! JSONDecoder().decode([CategoryModel].self, from: data!)
            let db = try! Realm()
            try! db.write {
                for item in categories {
                    let itemDB = db.object(ofType: CategoryModel.self, forPrimaryKey: item.id)

                    if itemDB == nil {
                        print("Brak kategorii, dodaję")
                        db.add(item)
                    }
                }
            }

            dispatchGroup.leave()
        })

        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
    }

    private func loadProductsFromAPI() {
        let serverURL = "http://127.0.0.1:8080/produkt"

        let url = URL(string: serverURL)
        let request = URLRequest(url: url!)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let dispatchGroup = DispatchGroup()

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                print("Houston mamy problem")
                return
            }

            guard data != nil else {
                print("Nie ma danych")
                return
            }


            let categories = try! JSONDecoder().decode([ProductModel].self, from: data!)
            let db = try! Realm()
            try! db.write {
                for item in categories {
                    let itemDB = db.object(ofType: ProductModel.self, forPrimaryKey: item.id)

                    if itemDB == nil {
                        print("Brak produkt, dodaję")
                        db.add(item)
                    }
                }
            }

            dispatchGroup.leave()
        })

        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
    }
    
    private func loadShopsFromApi() {
        let serverURL = "http://127.0.0.1:8080/shop"

        let url = URL(string: serverURL)
        let request = URLRequest(url: url!)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let dispatchGroup = DispatchGroup()

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                print("Houston mamy problem")
                return
            }

            guard data != nil else {
                print("Nie ma danych")
                return
            }


            let categories = try! JSONDecoder().decode([ShopModel].self, from: data!)
            let db = try! Realm()
            try! db.write {
                for item in categories {
                    let itemDB = db.object(ofType: ShopModel.self, forPrimaryKey: item.id)

                    if itemDB == nil {
                        print("Brak sklepu, dodaję")
                        db.add(item)
                    }
                }
            }

            dispatchGroup.leave()
        })

        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
    }
}
