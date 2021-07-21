//
//  SearchAPI.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/07.
//

import Foundation
import Moya

class SearchAPI {
    static let shared = SearchAPI()
    static let provider = MoyaProvider<SearchService>()

    
    func getSearchFilterResult(param: SearchFilterRequest, completion: @escaping (SearchResultResponse, Bool) -> ()) {
        SearchAPI.provider.request(.searchFilter(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(SearchResultDataModel.self, from: result.data)
                    print("getSearchFilterResult: \(results.message)")
                    guard let data = results.data else {
                        return
                    }
                    completion(data, results.success)
                } catch let err {
                    print("JSONDecode: \(err.localizedDescription)")
                    debugPrint(err)
                }
            case .failure(let err):
                print(".failure: \(err.localizedDescription)")
            }
        }
    }
    
    func getKeywordResult(param: String, completion: @escaping (SearchResultResponse) -> ()) {
        SearchAPI.provider.request(.searchKeyword(keyword: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(SearchResultDataModel.self, from: result.data)
                    print("getSearchKeywordResult: \(results.message)")
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
    
    func getPopularSearch(completion: @escaping ([PopularResponse]) -> ()) {
        SearchAPI.provider.request(.searchWindow) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(PopularDataModel.self, from: result.data)
                    print("getPopularSearch: \(results.message)")
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
