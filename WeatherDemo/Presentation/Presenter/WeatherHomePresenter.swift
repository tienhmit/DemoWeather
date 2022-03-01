//
//  WeatherHomePresenter.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Foundation

protocol WeatherHomeDelegate {
    func reloadView()
}

class WeatherHomePresenter: NSObject {
    var delegate: WeatherHomeDelegate? = nil
    static let sheared = WeatherHomePresenter()
    private let cityLocationUseCase: CityLocationUseCaseInterface
    private let weatherUseCase: WeatherUseCaseInterface
    var cityLocationModels = [CityLocationModel]()
    var wetherModel = WeatherModel()
    
    private init(cityLocationUseCase: CityLocationUseCaseInterface = CityLocationUseCase(),
                 weatherUseCase: WeatherUseCaseInterface = WeatherUseCase()) {
        self.cityLocationUseCase = cityLocationUseCase
        self.weatherUseCase = weatherUseCase
    }
    
    func fetchCityLocationModel(locationName: String) {
        cityLocationUseCase.fetch(locationName: locationName) { [weak self] cityLocationModels in
            self?.cityLocationModels = cityLocationModels
            self?.fetWeatherModel(latitude: cityLocationModels.first?.latitude ?? 0, longitude: cityLocationModels.first?.longitude ?? 0)
            self?.delegate?.reloadView()
        }
    }
    
    func fetWeatherModel(latitude: Double,
                         longitude: Double) {
        weatherUseCase.fetch(latitude: latitude,
                             longitude: longitude) { [weak self] weatherModel in
                                guard let model = weatherModel else { return }
                                self?.wetherModel = model
                                self?.delegate?.reloadView()
        }
    }
}
