//
//  BaseFetcher.swift
//  DemoApp
//
//  Created by Hoang Manh Tien on 2/27/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import SwiftyJSON
import Alamofire

enum APIDataType {
    case formData
    case jsonData
    case querryString
    
    var dataType: ParameterEncoding {
        switch self {
        case .formData:
            return URLEncoding.httpBody
        case .jsonData:
            return JSONEncoding.default
        case .querryString:
            return URLEncoding.queryString
        }
    }
    
    var httpHeaders: HTTPHeaders {
        switch self {
        case .formData:
            return ["Accept": "application/json",
                    "Content-Type": "application/x-www-form-urlencoded",
                    "Transfer-Encoding": "chunked"]
        case .jsonData, .querryString:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Transfer-Encoding": "chunked"]
        }
    }
}

protocol RequestConditions {
    var baseURL: String { get }
    var apiURL: String { get }
    var params: [String: Any] { get }
    var method: HTTPMethod { get }
    var dataType: APIDataType { get }
}

extension RequestConditions {
    var urlString: String {
        baseURL.appending(apiURL)
    }
}

protocol BaseFetcherInterface {
    func startFetch(requestConditions: RequestConditions,
                      complete: @escaping (Data) -> (),
                      failure: @escaping (Error) -> ())
}

final class BaseFetcher {
    static let shared = BaseFetcher()
    
    private lazy var alamoFireManager: SessionManager = SessionManager()
}

extension BaseFetcher: BaseFetcherInterface {
    func startFetch(requestConditions: RequestConditions,
                    complete: @escaping (Data) -> (),
                    failure: @escaping (Error) -> ()) {
        fetchRequest(
            requestConditions: requestConditions,
            complete: { data in
                complete(data)},
            failure: { error in
                failure(error)
        })
    }
}

private extension BaseFetcher {
    private func dataRequest(requestConditions: RequestConditions) -> DataRequest {
        alamoFireManager.request(requestConditions.urlString,
                                 method: requestConditions.method,
                                 parameters: requestConditions.params,
                                 encoding: requestConditions.dataType.dataType,
                                 headers: requestConditions.dataType.httpHeaders)
    }
    
    private func fetchRequest(requestConditions: RequestConditions,
                              complete: @escaping (Data) -> (),
                      failure: @escaping (Error) -> ()) {
        let _ = dataRequest(requestConditions: requestConditions)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        return
                    }
                    complete(data)
                case .failure:
                    guard let error = response.error else {
                        return
                    }
                    failure(error)
                }
        }
    }
}
