//
//  ShowViewCell.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit
//protocol favouriteDelegate:class {
//    func didSelectFavourite(_ favourite: Favourite, toggle:Int)
//}

class ShowViewCell: UITableViewCell {

    @IBOutlet weak var openingState: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var nameLabl: UILabel!
    
    var favouriteToggleState = 1
    
    let filledImg = UIImage(named:"filled_star.png")
    let emptyImg = UIImage(named:"empty_star.png")
    
    private var payload:Payload?
    private var rowCount = 0
    weak var delegate: favouriteDelegate?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
      }
    
    var restViewModel:ModifyCellViewModel!{
        didSet{
            nameLabl?.text = restViewModel.restaurantName
            openingState?.text = restViewModel.status
            self.payload = restViewModel.payload
            self.favouriteBtn.setImage(restViewModel.imageType,for:.normal)
             restViewModel.setStatuLabelColor(label:self.openingState)
        }
    }
    
    
      func configureCell(_ delegate:favouriteDelegate, rowCount:Int)
        {
            self.rowCount = rowCount
            self.delegate = delegate
        }

    
    @IBAction func selectFav(_ sender: Any) {
        if favouriteToggleState == StarCheked.On.rawValue {
                    favouriteToggleState = StarCheked.Off.rawValue
            self.favouriteBtn.setImage(restViewModel.filledImg,for:.normal)
            setFavourite(toggle: StarCheked.On.rawValue)
        }
        else {
            favouriteToggleState = StarCheked.On.rawValue
            self.favouriteBtn.setImage(restViewModel.emptyImg,for:.normal)
            setFavourite(toggle: StarCheked.Off.rawValue)
    }
}
    

    func setFavourite(toggle:Int)
    {
        if let payload = self.payload{
            let fav = Favourite(id:self.rowCount+1, name: payload.name, status: payload.status)
            delegate?.didSelectFavourite(fav,toggle: toggle)
        }
    }
    
}
