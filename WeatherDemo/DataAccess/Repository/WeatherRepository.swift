//
//  WeatherRepository.swift
//  DemoApp
//
//  Created by Hoang Manh Tien on 2/27/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Alamofire

protocol WeatherRepositoryInterface {
    func fetch(latitude: Double,
               longitude: Double,
               complete: @escaping (WeatherModel?) -> Void)
}

struct WeatherRepository {
    private let fetcher: BaseFetcherInterface
    
    init(fetcher: BaseFetcherInterface = BaseFetcher.shared) {
        self.fetcher = fetcher
    }
}

extension WeatherRepository: WeatherRepositoryInterface {
    func fetch(latitude: Double,
               longitude: Double,
               complete: @escaping (WeatherModel?) -> Void) {
        fetcher.startFetch(
            requestConditions: WeatherRequestConditionsType.byLocation(latitude, longitude),
            complete: { data in
                do {
                    let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                    complete(weatherModel)
                }
                catch {
                    complete(nil)
                }},
            failure: { error in
                complete(nil) })
    }
}

enum WeatherRequestConditionsType {
    case byLocation(Double, Double)
}

extension WeatherRequestConditionsType: RequestConditions {
    var baseURL: String {
        "https://api.openweathermap.org/data/2.5"
    }
    
    var apiURL: String {
        "/weather"
    }
    
    var params: [String: Any] {
        switch self {
        case let .byLocation(latitude, longitude):
            return ["lat": latitude,
                    "lon": longitude,
                    "appid": "4d1a1b39868241cfc34a0c7c8f1186e6"]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var dataType: APIDataType {
        .querryString
    }
}
