//
//  NetworkManager.swift
//  SampleURLSession
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 Bhanu. All rights reserved.
//

import Foundation
import Combine

final class RequestMethod {
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }

    static func request(method: Method, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 60
        return urlRequest
    }
}

enum NetworkError: LocalizedError {
    case someThingWrong
    case noInternet

    var errorDescription: String? {
        switch self {
        case .someThingWrong:
            return "Something went wrong"
        case .noInternet:
            return "Please check your Internet Connection"
        }
    }
}

class RequestManager {

    static let sharedService = RequestManager()

    func requestAPI<T: Decodable>(requestType: RequestMethod.Method, urlString: String,
                                  params: [String: AnyObject]? = nil) -> AnyPublisher<T, NetworkError> {
        if let reachability = Reachability(), !reachability.isReachable {
            return Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        }

        print("URL =====>\(urlString)")
        guard let url = URL(string: urlString) else {
            print("Something went wrong")
            return Fail(error: NetworkError.someThingWrong).eraseToAnyPublisher()
        }
    
        var urlRequest = RequestMethod.request(method: requestType, url: url)
        if params != nil{
            let postData = try? JSONSerialization.data(withJSONObject: params!, options: .init(rawValue: 0))
            urlRequest.httpBody = postData
            
            let jsonInputData = try? JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
            let prettyString = String(data:jsonInputData!, encoding:String.Encoding.utf8)
            print("params ====>\(prettyString!)")
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { _ in Fail(error: NetworkError.someThingWrong).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}
