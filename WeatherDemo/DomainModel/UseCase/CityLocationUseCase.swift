//
//  CityLocationUseCase.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

protocol CityLocationUseCaseInterface {
    func fetch(locationName: String,
               complete: @escaping ([CityLocationModel]) -> Void)
}

final class CityLocationUseCase {
    private let cityLocationRepository: CityLocationRepositoryInterface
    
    init(cityLocationRepository: CityLocationRepositoryInterface = CityLocationRepository()) {
        self.cityLocationRepository = cityLocationRepository
    }
}

extension CityLocationUseCase: CityLocationUseCaseInterface {
    func fetch(locationName: String,
               complete: @escaping ([CityLocationModel]) -> Void) {
        cityLocationRepository.fetch(localtionName: locationName, complete: complete)
    }
}
