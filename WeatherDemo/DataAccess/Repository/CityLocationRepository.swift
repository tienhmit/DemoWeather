//
//  CityLocationRepository.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Alamofire

protocol CityLocationRepositoryInterface {
    func fetch(localtionName: String,
               complete: @escaping ([CityLocationModel]) -> Void)
}

struct CityLocationRepository {
    private let fetcher: BaseFetcherInterface
    
    init(fetcher: BaseFetcherInterface = BaseFetcher.shared) {
        self.fetcher = fetcher
    }
}

extension CityLocationRepository: CityLocationRepositoryInterface {
    func fetch(localtionName: String,
               complete: @escaping ([CityLocationModel]) -> Void) {
        fetcher.startFetch(
            requestConditions: CityLocationConditionsType.byCityName(localtionName),
            complete: { data in
                do {
                    let cityLocationModels = try JSONDecoder().decode([CityLocationModel].self, from: data)
                    complete(cityLocationModels)
                } catch {
                    complete([])
                }},
            failure: { error in
                complete([]) })
    }
}

enum CityLocationConditionsType {
    case byCityName(String)
}

extension CityLocationConditionsType: RequestConditions {
    var baseURL: String {
        "http://api.openweathermap.org/geo/1.0/"
    }
    
    var apiURL: String {
        "/direct"
    }
    
    var params: [String: Any] {
        switch self {
        case .byCityName(let cityName):
            return ["q": cityName,
                    "limit": 0,
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
