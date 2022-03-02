//
//  CityLocationRepository.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Alamofire


protocol CityLocationRepositoryInterface {
    // API Interface
    func fetch(locationName: String,
               complete: @escaping ([CityLocationModel]) -> Void)
    // CoreData Interface
    func insert(models: [CityLocationModel]) throws
    func fetch(coreDataConditions: CoreDataConditions) throws -> [CityLocationModel]
    func delete(models: [CityLocationModel]) throws
}




struct CityLocationRepository {
    private let fetcher: BaseFetcherInterface
    private let coreDataAccess: BaseCoreDataInterface
    
    init(fetcher: BaseFetcherInterface = BaseFetcher.shared,
         coreDataAccess: BaseCoreDataInterface = BaseCoreData()) {
        self.fetcher = fetcher
        self.coreDataAccess = coreDataAccess
    }
}

extension CityLocationRepository: CityLocationRepositoryInterface {
    // API
    func fetch(locationName: String,
               complete: @escaping ([CityLocationModel]) -> Void) {
        fetcher.startFetch(
            requestConditions: CityLocationConditionsType.byCityName(locationName),
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
    
    // CoreData
    func insert(models: [CityLocationModel]) throws {
        try coreDataAccess.insert(models: models)
    }
    
    func fetch(coreDataConditions: CoreDataConditions) throws -> [CityLocationModel] {
        let condition = CityLocationModelCoreDataConditionType.all
        let results: [CityLocationModel] = try coreDataAccess.fetch(conditions: condition)
        return results
    }
    
    func delete(models: [CityLocationModel]) throws {
        try coreDataAccess.delete(models: models)
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
                    "appid": "08869d29f8e15af55cd59f0a6127b31f"]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var dataType: APIDataType {
        .querryString
    }
}
