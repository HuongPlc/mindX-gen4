//
//  ViewController.swift
//  MindX
//
//  Created by Hoang Van Pau on 9/3/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var worldPopulationLabel: UILabel!
    @IBOutlet var totalCountrieslabel: UILabel!

    private var allCountry: Country = Country(countries: []) {
        didSet {
            searchName = allCountry.countries
        }
    }

    private var searchName: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private var worldPopulation: Double = 0 {
        didSet {
            DispatchQueue.main.async {
                self.worldPopulationLabel.text = "\(self.worldPopulation)"
            }
        }
    }

    private var numCountries: Double = 0 {
        didSet {
            DispatchQueue.main.async {
                self.totalCountrieslabel.text = "\(self.numCountries)"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        
        searchBar.delegate = self
        
        AllCountryService.getAll { result in
            switch result {
            case let .success(data):
                self.allCountry = data.body
            case let .failure(error):
                print("error: \(error.message)")
            }
        }

        WorldPopulationService.getInfo { result in
            switch result {
            case let .success(data):
                self.worldPopulation = data.body.world_population
                self.numCountries = data.body.total_countries
            case let .failure(error):
                print("error: \(error.message)")
            }
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.countryDetail = CoutryDetail(name: allCountry.countries[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchName[indexPath.row]
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchName = allCountry.countries
            return
        }
        searchName = allCountry.countries.filter {
            return $0.lowercased().contains("\(searchBar.text?.lowercased() ?? "")")
        }
    }
}
