//
//  API.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/04.
//

import Foundation
import Moya

class OnboardingAPI {
    static let shared = OnboardingAPI()
    static let provider = MoyaProvider<OnboardingService>()

    func postOnboarding(param: OnboardingRequest, accesstoken: String ,completion: @escaping (OnBoardingDataModel) -> ()) {
        OnboardingAPI.provider.request(.onboarding(param: param, accesstoken: accesstoken)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(OnBoardingDataModel.self, from: result.data)
                    print("OnboadingAPI - postOnboarding():\(results.message)")
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
    
    func getHome(accesstoken: String, completion: @escaping (HomeResponse) -> ()) {
        OnboardingAPI.provider.request(.home(accesstoken: accesstoken)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(HomeDataModel.self, from: result.data)
                    print("OnboadingAPI - getHome(): \(results.success)")
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
