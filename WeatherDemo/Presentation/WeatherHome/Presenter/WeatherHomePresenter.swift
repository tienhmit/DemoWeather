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
    private let cityLocationUseCase: CityLocationUseCaseInterface
    private let weatherUseCase: WeatherUseCaseInterface
    var infos = [(CityLocationModel, WeatherModel)]()
    
    init(cityLocationUseCase: CityLocationUseCaseInterface = CityLocationUseCase(),
                 weatherUseCase: WeatherUseCaseInterface = WeatherUseCase()) {
        self.cityLocationUseCase = cityLocationUseCase
        self.weatherUseCase = weatherUseCase
    }
    
    func fetchCityLocationModel(locationName: String) {
        cityLocationUseCase.fetch(locationName: locationName) { [weak self] cityLocationModels in
            self?.fetchWeather(by: cityLocationModels)
            self?.delegate?.reloadView()
        }
    }
    
    func fetchWeather(by cityLocationModels: [CityLocationModel]) {
        infos.removeAll()
        for city in cityLocationModels {
            weatherUseCase.fetch(latitude: city.latitude,
                                 longitude: city.longitude) { [weak self] weatherModel in
                                    guard let model = weatherModel else { return }
                                    self?.infos.append((city, model))
                                    self?.delegate?.reloadView()
            }
        }
    }
    
    func addFavouriteAction(cityLocationModel: CityLocationModel) {
        if !AppUserDefault.isAddedFavourite() {
            AppUserDefault.setIsAddedFavourite()
        }
        insertFavourite(models: [cityLocationModel])
    }
    
    func deleteFavouriteAction(at index: Int) {
        let deleteModel = infos[index].0
        infos.remove(at: index)
        deleteFavourite(models: [deleteModel])
    }
    
    // CoreData
    func fetchFavourite() {
        let condition = CityLocationModelCoreDataConditionType.all
        let cityLocationModels = cityLocationUseCase.fetch(coreDataConditions: condition)
        fetchWeather(by: cityLocationModels)
    }
    
    func insertFavourite(models: [CityLocationModel]) {
        cityLocationUseCase.insert(models: models)
    }
    
    func deleteFavourite(models: [CityLocationModel]) {
        cityLocationUseCase.delete(models: models)
    }
}
