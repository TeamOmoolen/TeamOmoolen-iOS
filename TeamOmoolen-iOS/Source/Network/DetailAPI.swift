//
//  DetailAPI.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/13.
//

import Foundation
import Moya

class DetailAPI {
    static let shared = DetailAPI()
    static let provider = MoyaProvider<DetailService>()

    
    // get data
    func getProductDetail(param: String, completion: @escaping (ProductDetailResponse) -> ()) {
        DetailAPI.provider.request(.product(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(ProductDetailDataModel.self, from: result.data)
                    print("getProductDetail: \(results.message)")
                    guard let data = results.data else {
                        return
                    }
                    completion(data)
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
                                                                                                                                                                                                                                                              
