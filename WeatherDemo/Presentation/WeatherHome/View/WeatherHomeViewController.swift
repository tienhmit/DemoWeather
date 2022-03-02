//
//  WeatherHomeViewController.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import UIKit

class WeatherHomeViewController: BaseViewController {
    
    //MARK: - Properties
    private let presenter = WeatherHomePresenter()
    private var isSearchLocation = false
    private let weatherHomeCellIdentifier = "WeatherHomeCell"
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.fetchCityLocationModel(locationName: "Hanoi")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "DetailSegue":
            guard let destination = segue.destination as? DetailViewController else { return }
            destination.setUp(info: sender as! (CityLocationModel, WeatherModel))
        default:
            break
        }
    }
}

//MARK: - Public Function
extension WeatherHomeViewController {
    func setUp() {
        let wetherNib = UINib(nibName: weatherHomeCellIdentifier, bundle: nil)
        tableView.register(wetherNib, forCellReuseIdentifier: weatherHomeCellIdentifier)
        tableView.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 0.7)
        presenter.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension WeatherHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.cityLocationModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = (presenter.cityLocationModels[indexPath.row],
                    presenter.wetherModel)
        let cell = tableView.dequeueReusableCell(withIdentifier: weatherHomeCellIdentifier) as! WeatherHomeCell
        cell.setup(info: info)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Favourite Locations"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}

//MARK: - UITableViewDelegate
extension WeatherHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = (presenter.cityLocationModels[indexPath.row],
                    presenter.wetherModel)
        performSegue(withIdentifier: "DetailSegue", sender: info)
    }
}

//MARK: - UITableViewDelegate
extension WeatherHomeViewController: WeatherHomeDelegate {
    func reloadView() {
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension WeatherHomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearchLocation = false
            presenter.fetchCityLocationModel(locationName: "Hanoi")
        } else {
            isSearchLocation = true
            presenter.fetchCityLocationModel(locationName: searchText)
        }
    }
}
