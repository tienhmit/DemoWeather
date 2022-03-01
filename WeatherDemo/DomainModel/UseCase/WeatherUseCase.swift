//
//  WeatherUseCase.swift
//  DemoApp
//
//  Created by Hoang Manh Tien on 2/27/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

protocol WeatherUseCaseInterface {
    func fetch(latitude: Double,
               longitude: Double,
               complete: @escaping (WeatherModel?) -> Void)
}

final class WeatherUseCase {
    private let weatherRepository: WeatherRepositoryInterface
    
    init(weatherRepository: WeatherRepositoryInterface = WeatherRepository()) {
        self.weatherRepository = weatherRepository
    }
}

extension WeatherUseCase: WeatherUseCaseInterface {
    func fetch(latitude: Double,
               longitude: Double,
               complete: @escaping (WeatherModel?) -> Void) {
                weatherRepository.fetch(latitude: latitude, longitude: longitude, complete: complete)
    }
}
