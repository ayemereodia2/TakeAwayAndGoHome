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
    
    var favouriteToggleState = 2
    
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
            let ts = DBHelper.shared.getAllFavourite()

            nameLabl?.text = restViewModel.restaurantName
            openingState?.text = restViewModel.status
            self.payload = restViewModel.payload
             restViewModel.setStatuLabelColor(label:self.openingState)
            
            if ts.contains(where: {$0.name == restViewModel.restaurantName}){
                print("*Yes")
                  self.favouriteBtn.setImage(filledImg,for:.normal)
            }
            else{
                print("#No")
                    self.favouriteBtn.setImage(emptyImg,for:.normal)
            }
        }
    }
    
    
      func configureCell(_ delegate:favouriteDelegate, rowCount:Int)
        {
            self.rowCount = rowCount
            self.delegate = delegate
        }

    
    @IBAction func selectFav(_ sender: UIButton) {
        
        if emptyImg == sender.currentImage{
                  self.favouriteBtn.setImage(restViewModel.filledImg,for:.normal)
                  setFavourite(toggle: 1)
        }else{
            //favouriteToggleState = 1
            self.favouriteBtn.setImage(restViewModel.emptyImg,for:.normal)
            setFavourite(toggle: 2)
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
