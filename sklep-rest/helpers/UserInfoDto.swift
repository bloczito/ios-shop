
struct UserInfo: Decodable {
    let sub: String
    let given_name: String
    let family_name: String
    let nickname: String
    let name: String
    let picture: String
    let locale: String
    let updated_at: String
//    init(sub: String) {
//        self.sub = sub
//    }
}
