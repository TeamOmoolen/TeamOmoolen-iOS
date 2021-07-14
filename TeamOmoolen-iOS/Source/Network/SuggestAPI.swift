//
//  SuggestAPI.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/13.
//

import Foundation
import Moya

class SuggestAPI {
    static let shared = SuggestAPI()
    static let provider = MoyaProvider<SuggestService>()

    // get data
    func getSuggest(accesstoken: String, completion: @escaping (SuggestResponse) -> ()) {
        SuggestAPI.provider.request(.suggest(accesstoken: accesstoken)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(SuggestDataModel.self, from: result.data)
                    print("getSearchFilterResult: \(results.message)")
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
    
    func getForyou(accesstoken: String, page: Int, sort: String, order: String, completion: @escaping (SuggestDetailResponse) -> ()) {
        SuggestAPI.provider.request(.suggestForyou(accesstoken: accesstoken, page: page, sort: sort, order: order)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(SuggestDetailDataModel.self, from: result.data)
                    print("SuggestAPI - getForyou(): \(results.message)")
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
    
    func getSituation(accesstoken: String, page: Int, sort: String, order: String, completion: @escaping (SuggestDetailResponse) -> ()) {
        SuggestAPI.provider.request(.suggestForyou(accesstoken: accesstoken, page: page, sort: sort, order: order)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(SuggestDetailDataModel.self, from: result.data)
                    print("SuggestAPI - getSituation(): \(results.message)")
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
