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
        presenter.fetchFavourite()
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

private extension WeatherHomeViewController {
    private func addFavouriteSwipeAction(cityLocationModel: CityLocationModel) {
        presenter.addFavouriteAction(cityLocationModel: cityLocationModel)
    }

    private func deleteFavouriteSwipeAction(at index: Int) {
        presenter.deleteFavouriteAction(at: index)
        reloadView()
    }
}

//MARK: - UITableViewDataSource
extension WeatherHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.infos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weatherHomeCellIdentifier) as! WeatherHomeCell
        cell.setup(info: presenter.infos[indexPath.row])
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
        let info = presenter.infos[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: info)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let title = isSearchLocation ? "Add" : "Delete"
        let action = UIContextualAction(style: .normal,
                                        title: title) { [weak self] (action, view, completionHandler) in
                                            guard let strongSelf = self else { return }
                                            strongSelf.isSearchLocation ?
                                                strongSelf.addFavouriteSwipeAction(cityLocationModel: strongSelf.presenter.infos[indexPath.row].0) :
                                                strongSelf.deleteFavouriteSwipeAction(at: indexPath.row)
                                            completionHandler(true)
        }
        action.backgroundColor = isSearchLocation ? #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) : .red
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if isSearchLocation {
            return .insert
        } else {
            return .delete
        }
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
            presenter.fetchFavourite()
        } else {
            isSearchLocation = true
            presenter.fetchCityLocationModel(locationName: searchText)
        }
    }
}
