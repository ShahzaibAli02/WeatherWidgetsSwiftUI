//
//  ApiHandler.swift
//  App
//
//  Created by Shahzaib Ali on 01/08/2024.
//

import Foundation
import Alamofire

struct ApiHandler{
    
    let BASE_URL = "https://ncmportal.centric.ae/"
    private  let AUTH_KEY = "N2ZmNjIwZDMwODQ3YTU4NDFmMDczOTE0NzliMjhjMTliYThmMDFhNDozOGU0ZTViYWNkMDNkZjQ0YjExMjRjOWQ3MWMxZDM2Mzk3NzEyOWQyYzQwMzFlZDMzYWY2NjljNWVlMDdjNDE0"
    private let TAG = "ApiHandler"
    
    var headers: HTTPHeaders {
        return [
            "Content-Type": "text/plain",
            "Authorization": "Basic \(AUTH_KEY)"
        ]
    }

    
    func loadRouteQueryApi(parameters: [String: Any]) async -> Result<ApiResponse?> {
        
        
        let url = "\(BASE_URL)api/ncm/device/route-query"
        return await withCheckedContinuation { continuation in
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let weatherResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                        continuation.resume(returning:  Result(data: weatherResponse))
                    } catch let error {
                        print("\(TAG) => Failed to decode JSON: \(error.localizedDescription)")
                        continuation.resume(returning:  Result(errorCode: Constants.ERROR_API, message: error.localizedDescription, description: ""))
                    }
                case .failure(let error):
                    continuation.resume(returning:  Result(errorCode: Constants.ERROR_API, message: error.localizedDescription, description: ""))
                }
            }
            
        }
        
        
    }
    
    
    
    func loadPublicQuery(parameters: [String: Any]) async -> Result<ApiResponse?> {
        
        
        let url = "\(BASE_URL)api/ncm/device/public-query"
        return await withCheckedContinuation { continuation in
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        
                        let weatherResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                        continuation.resume(returning:  Result(data: weatherResponse))
                    } catch let error {
                        print("\(TAG) => Failed to decode JSON: \(error.localizedDescription)")
                        continuation.resume(returning:  Result(errorCode: Constants.ERROR_API, message: error.localizedDescription, description: ""))
                    }
                case .failure(let error):
                    continuation.resume(returning:  Result(errorCode: Constants.ERROR_API, message: error.localizedDescription, description: ""))
                }
            }
            
        }
        
        
    }
    
    
    

    
}
