//
//  LoginAPI.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/09.
//

import Foundation
import Moya

class LoginAPI {
    static let shared = LoginAPI()
    static let provider = MoyaProvider<LoginService>()

    
    
    func postAppleLogin(param: AppleLoginRequest, completion: @escaping (AppleLoginDataModel) -> ()) {
        LoginAPI.provider.request(.login(param: param)) { response in
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(AppleLoginDataModel.self, from: result.data)
                    completion(results)
                } catch let err {
                    print("JSONDecode: \(err.localizedDescription)")
                    debugPrint(err)
                }
            case .failure(let err):
                print(".failure: \(err.localizedDescription)")
            }
        }
    }
}
