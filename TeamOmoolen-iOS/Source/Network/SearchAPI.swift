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

    
    // get data
    func getSearchFilterResult(param: SearchFilterRequest, completion: @escaping (SearchResultResponse) -> ()) {
        SearchAPI.provider.request(.searchFilter(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(SearchResultDataModel.self, from: result.data)
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
    
    //get data for keyWord Result
    func getKeywordResult(param: SearchKeywordRequest, completion: @escaping (SearchResultResponse) -> ()) {
        SearchAPI.provider.request(.searchKeyword(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(SearchResultDataModel.self, from: result.data)
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
