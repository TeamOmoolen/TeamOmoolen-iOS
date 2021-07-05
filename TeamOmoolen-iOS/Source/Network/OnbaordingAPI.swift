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

    func postOnboardingWithAPI(param: OnboardingRequest, completion: @escaping (OnboardingResponse) -> ()) {
        OnboardingAPI.provider.request(.onboarding(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(OnBoardingDataModel.self, from: result.data)
                    print(results.message)
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
