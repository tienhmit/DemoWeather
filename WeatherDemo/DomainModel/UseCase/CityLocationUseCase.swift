//
//  CityLocationUseCase.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

protocol CityLocationUseCaseInterface {
    // API Interface
    func fetch(locationName: String,
               complete: @escaping ([CityLocationModel]) -> Void)
    // CoreData Interface
    func insert(models: [CityLocationModel])
    func fetch(coreDataConditions: CoreDataConditions) -> [CityLocationModel]
    func delete(models: [CityLocationModel])
}

final class CityLocationUseCase {
    private let cityLocationRepository: CityLocationRepositoryInterface
    
    init(cityLocationRepository: CityLocationRepositoryInterface = CityLocationRepository()) {
        self.cityLocationRepository = cityLocationRepository
    }
}

extension CityLocationUseCase: CityLocationUseCaseInterface {
    // API Interface
    func fetch(locationName: String,
               complete: @escaping ([CityLocationModel]) -> Void) {
        cityLocationRepository.fetch(locationName: locationName, complete: complete)
    }
    
    // CoreData Interface
    func insert(models: [CityLocationModel]) {
        do {
            try cityLocationRepository.insert(models: models)
        } catch {
            // Error
        }
    }
    
    func fetch(coreDataConditions: CoreDataConditions) -> [CityLocationModel] {
        do {
            return try cityLocationRepository.fetch(coreDataConditions: coreDataConditions)
        } catch {
            // Error
            return []
        }
    }
    
    func delete(models: [CityLocationModel]) {
        do {
            return try cityLocationRepository.delete(models: models)
        } catch {
            // Error
        }
    }
}
