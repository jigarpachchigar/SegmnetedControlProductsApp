//
//  Item.swift
//  SegmnetedProductsApp
//
//  Created by Mervat Mustafa on 2020-11-25.
//

import Foundation
class Item{
    var itemCat:String
    var itemName:String
    var itemPrice:Double
    var itemdesc:String
    
    init(cat:String, name:String, price:Double , desc:String){
        self.itemCat = cat
        self.itemName = name
        self.itemPrice = price
        self.itemdesc = desc
    }
}
