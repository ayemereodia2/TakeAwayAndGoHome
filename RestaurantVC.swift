//
//  RestaurantVC.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit

class RestaurantVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    // MARK: - UI

    @IBOutlet weak var showActionSheet: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var headingMenu:UIAlertController!

    // MARK: - Properties
           var viewModel:RestaurantVM!
           public var restaurants = [Payload]()
           private var tempList = [Payload]()
           private var filtered = [Payload]()
           private var favourites = [Favourite]()
    
    public var options:[Payload] = []
    private var selection:(([String])->Void)? = nil
           var search:Bool = false
    // MARK: - Life Cycle

           override func viewDidLoad() {
               super.viewDidLoad()
               tableView.dataSource = self
               tableView.delegate = self
               setUpCell()
               searchBar.delegate = self
              viewModel.restaurantDelegate = self
               setUpViewModel()
           }
    
    convenience init(options:[Payload], selection: @escaping([String])->Void) {
        self.init()
        self.options = options
        self.selection = selection
    }
    
    func setUpViewModel(){
        restaurants = viewModel.listOfRestaurants
        tempList = restaurants
        favourites = viewModel.listOffavourites
    }
    
    func setUpCell(){
        
        self.tableView.register(UINib.init(nibName: "ShowViewCell", bundle: nil), forCellReuseIdentifier:Identifiers.ShowViewCell)
    }
    
              
    @IBAction func showActionSheet(_ sender: Any) {
        setUpStyleSheet()
    }
    
    func setUpStyleSheet(){
        // 1
         headingMenu = UIAlertController(title: nil, message: "Sort By", preferredStyle: .actionSheet)
        headingMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
                 // Called when user taps outside
        }))
                      
        let bestAction = UIAlertAction(title: "Best Match", style: .default, handler:{_ in self.sortBy(option: .bestMatch)})
    
        let newestAction = UIAlertAction(title: "Newest", style: .default, handler:{_ in self.sortBy(option: .newest)})
                      
                  // 3
        let ratingAction = UIAlertAction(title: "Rating Average", style: .default, handler:{_ in self.sortBy(option: .ratingAverage)})

        let distanceAction = UIAlertAction(title: "Distance", style: .default, handler:{_ in self.sortBy(option: .distance)})
        let popularityAction = UIAlertAction(title: "Popularity", style: .default, handler:{_ in self.sortBy(option: .popularity)})
        let avpAction = UIAlertAction(title: "Average ProductPrice", style: .default, handler:{_ in self.sortBy(option: .averageProductPrice)})
        let deliveryAction = UIAlertAction(title: "Delivery Costs", style: .default, handler:{_ in self.sortBy(option: .deliveryCosts)})
        let minCostAction = UIAlertAction(title: "Min Cost", style: .default, handler:{_ in self.sortBy(option: .minCost)})
                      
                  // 4
               headingMenu.addAction(bestAction)
               headingMenu.addAction(newestAction)
               headingMenu.addAction(ratingAction)
               headingMenu.addAction(distanceAction)
               headingMenu.addAction(popularityAction)
               headingMenu.addAction(avpAction)
               headingMenu.addAction(deliveryAction)
               headingMenu.addAction(minCostAction)
                  self.present(headingMenu, animated: true, completion: nil)
    }

    
    
}

extension RestaurantVC :favouriteDelegate,RestaurantVMDelegate, UISearchBarDelegate{

    func sortBy(option: SortBy){
        viewModel.getRestaurant()
        restaurants = viewModel.listOfRestaurants
        switch (option) {
        case .minCost:
            restaurants = restaurants.sorted{$0.sortingValues.minCost > $1.sortingValues.minCost }
            tableView.reloadData()
                break;
        case .averageProductPrice:
            restaurants = restaurants.sorted{$0.sortingValues.averageProductPrice > $1.sortingValues.averageProductPrice }
                       tableView.reloadData()
            break;
        case .bestMatch:
            restaurants = restaurants.sorted{$0.sortingValues.bestMatch > $1.sortingValues.bestMatch }
                tableView.reloadData()
                break;
        case .distance:
            restaurants = restaurants.sorted{$0.sortingValues.distance > $1.sortingValues.distance }
                tableView.reloadData()
            break;
        case .newest:
                restaurants = restaurants.sorted{$0.sortingValues.newest > $1.sortingValues.newest }
                    tableView.reloadData()
                    break;
        case .popularity:
            restaurants = restaurants.sorted{$0.sortingValues.popularity > $1.sortingValues.popularity }
            tableView.reloadData()
            break;
        case .deliveryCosts:
                   restaurants = restaurants.sorted{$0.sortingValues.deliveryCosts > $1.sortingValues.deliveryCosts }
                   tableView.reloadData()
                   break;
            
        default:
            break;
        }
    }
    
    
    
    func didSelectFavourite(_ favourite: Favourite, toggle:Int) {
        if toggle == 2{
            DBHelper.shared.removeFromFav(favourite)
        }else{
            DBHelper.shared.addFavouritesToDb(favourite)
        }
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            restaurants = viewModel.listOfRestaurants
            tableView.reloadData()
        }
        else{
            //MARK :- refresh Favourites
            
            viewModel.getFavourites()
            favourites = viewModel.listOffavourites

            restaurants = restaurants.filter({( rest : Payload) -> Bool in
                return rest.name.lowercased().contains(searchText.lowercased())
                
            })
            tableView.reloadData()
        }
        
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
           
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 98.0
        }
               
               func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                    if !searchBarIsEmpty(){
                               return restaurants.count

                           } else {
                               return restaurants.count
                           }
                  }
               
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                   if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ShowViewCell{
                    cell.configureCell(self, rowCount: indexPath.row)
                    
                    cell.restViewModel = ModifyCellViewModel(payload: restaurants[indexPath.row], favourite: self.favourites)
                    
                    return cell

                   }
                   else{
                       return UITableViewCell()
                   }
                   
                }
    
    static func create(with viewModel: RestaurantVM) -> UIViewController {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let controller = storyboard.instantiateViewController(withIdentifier: "RestaurantVC") as! RestaurantVC
           controller.viewModel = viewModel
           return controller
       }
    
}
