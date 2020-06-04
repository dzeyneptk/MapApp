//
//  SearchVC.swift
//  MartiMap
//
//  Created by Zeynebim on 2.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Parameters
    private var googlePlaceVM = GooglePlaceVM()
    private var googleMapsVM = GoogleMapsVM()
    private var data: [String] = []
    
    private let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        googlePlaceVM.delegate = self
        googleMapsVM.delegate = self
        configureTableView()
        configureSearchVC()
    }
    
    // MARK: - Private Functions
    private func configureTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = searchBar
        self.tableView.backgroundColor = UIColor.white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func configureSearchVC() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Location"
        searchBar.searchBarStyle = .minimal
        searchBar.isUserInteractionEnabled = true
        searchBar.sizeToFit()
        definesPresentationContext = true
    }
    
    // MARK: - Override Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstant.segueIdentifier.searchToMap.description {
            let destination = segue.destination as! MapVC
            
            if let lat = googleMapsVM.g_lat {
                destination.latFromMap = lat
            }
            if let long = googleMapsVM.g_long {
                destination.longFromMap = long
            }
            if let adress = googleMapsVM.g_address {
                destination.nameFromSearch = adress
            }
        }
    }
}

// MARK: - UISearchDelegate
extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForTextSearch(searchText: String){
        googlePlaceVM.placeAutoComplete(text: searchText)
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBarIsEmpty()){
            searchBar.text = ""
        } else {
            googlePlaceVM.placeAutoComplete(text: searchText)
        }
    }
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForTextSearch(searchText: searchController.searchBar.text!)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return googlePlaceVM.placeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        googleMapsVM.getGeocode(by: self.data[indexPath.row])
    }
}

// MARK: - GooglePlaceDelegte
extension SearchVC: GooglePlaceDelegate {
    func failure(error: String?) {
        print(error ?? "")
    }
    
    func success() {
        data.removeAll()
        data = googlePlaceVM.getArray
        self.tableView.reloadData()
    }
}

// MARK: GoogleMapsDelegate
extension SearchVC: GoogleMapsDelegate {
    func failWith(error: String?) {
        print(error ?? "")
    }
    
    func succes() {
        self.performSegue(withIdentifier: AppConstant.segueIdentifier.searchToMap.description, sender: nil)
    }
}
