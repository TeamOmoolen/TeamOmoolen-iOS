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

    func postOnboarding(param: OnboardingRequest, completion: @escaping (OnBoardingDataModel) -> ()) {
        OnboardingAPI.provider.request(.onboarding(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(OnBoardingDataModel.self, from: result.data)
                    print("postOnboardingWithAPI\(results.message)")
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
    
    func getHome(completion: @escaping (HomeResponse) -> ()) {
        OnboardingAPI.provider.request(.home) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(HomeDataModel.self, from: result.data)
                    print("postOnboardingWithAPI\(results.message)")
                    completion(results.data)
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
