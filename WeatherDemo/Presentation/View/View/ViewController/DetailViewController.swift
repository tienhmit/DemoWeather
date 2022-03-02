//
//  DetailViewController.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    private let presenter = DetailPresenter()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtileLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var degLabel: UILabel!
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorLabel()
        reloadView()
    }
}

//MARK: - Public function
extension DetailViewController {
    func setUp(info: (CityLocationModel, WeatherModel)) {
        presenter.setUp(info: info)
    }
}

//MARK: - Public function
private extension DetailViewController {
    func setColorLabel() {
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        subtileLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        windSpeedLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        degLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func reloadView() {
        titleLabel.text = presenter.cityLocationModel.name
        subtileLabel.text = presenter.cityLocationModel.country + " (now)"
        windSpeedLabel.text = String(format: "%.1fm/s SE", presenter.wetherModel.windInfoModel.speed)
        degLabel.text = "Wind direction: \(presenter.wetherModel.windInfoModel.deg)º"
    }
}
