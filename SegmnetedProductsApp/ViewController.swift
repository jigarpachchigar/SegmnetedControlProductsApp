//
//  ViewController.swift
//  SegmnetedProductsApp
//
//  Created by Mervat Mustafa on 2020-11-25.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temp.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return temp[row].itemName
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemPrice.text = String(temp[row].itemPrice)
        itemdes.text = String(temp[row].itemdesc)

    }
    
    var array = [String]()
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var itemdes: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var itemsView: UIPickerView!
    @IBOutlet weak var itemSegment: UISegmentedControl!
        
    var products = [Item]()
    var temp = [Item]()
    var category = [String]()
    var total = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsView.dataSource = self
        itemsView.delegate = self
        fillCat()
        filldata()
        fillTemp(cat: itemSegment.titleForSegment(at: 0)!)
        itemPrice.text = String(temp[0].itemPrice)
        itemdes.text = String(temp[0].itemdesc)
       
    }
    func filldata(){
        products.append(Item(cat:category[0],name:"Tea",price:1.75,desc:"Tea"))
        products.append(Item(cat:category[0],name:"Coffee",price:2.30,desc:"Coffee"))
        products.append(Item(cat:category[0],name:"Juice",price:2.50,desc:"Juice"))
        products.append(Item(cat:category[0],name:"Soda",price:1.50,desc:"Soda"))
        products.append(Item(cat:category[0],name:"Beer",price:4.85,desc:"Beer"))
        products.append(Item(cat:category[1],name:"Cheese",price:4.25,desc:"Cheese"))
        products.append(Item(cat:category[1],name:"Butter",price:3.65,desc:"Butter"))
        products.append(Item(cat:category[1],name:"Curd",price:2.25,desc:"Curd"))
        products.append(Item(cat:category[1],name:"Milk",price:7.25,desc:"Milk"))
        products.append(Item(cat:category[2],name:"Buns",price:6.25,desc:"Buns"))
        products.append(Item(cat:category[2],name:"Cookies",price:3.2,desc:"Cookies"))
        products.append(Item(cat:category[2],name:"Muffins",price:10.25,desc:"Muffins"))
        products.append(Item(cat:category[2],name:"Rolls",price:8.25,desc:"Rolls"))
        products.append(Item(cat:category[2],name:"Breads",price:4.25,desc:"Breads"))
        products.append(Item(cat:category[3],name:"Rice",price:3.25,desc:"Rice"))
        products.append(Item(cat:category[3],name:"Wheat",price:6.25,desc:"Wheat"))
        products.append(Item(cat:category[3],name:"Maize",price:7.25,desc:"Maize"))
        products.append(Item(cat:category[3],name:"Millet",price:4.25,desc:"Millet"))
        products.append(Item(cat:category[3],name:"Sorghum",price:8.25,desc:"Sorghum"))
    }
    
    func fillTemp(cat:String){
        for item in products{
            if item.itemCat == cat{
                temp.append(item)
            //    tvfcart.text = String(item.itemPrice)
            }
        }
    }
    
    func fillCat()
    {
        for i in 0..<itemSegment.numberOfSegments{
            category.append(itemSegment.titleForSegment(at: i)!)
        }
        
    }

    @IBAction func getTotel(_ sender: Any) {
        total += Double(itemPrice.text!)! * 1.13
        totalPrice.text = String(format: "%.2f", total)
        
        array.append("\(itemdes.text as! String) : \(itemPrice.text as! String)")
        
        let defaults = UserDefaults.standard
        defaults.set(array, forKey: "SavedStringArray")
        
        
        
    }
    @IBAction func btnorder(_ sender: Any) {

        
        if totalPrice.text!.count > 0
        {
        let alert = UIAlertController(title: "Order Confirmed", message: "Your Ordered Placed Successfully", preferredStyle: UIAlertController.Style.alert)

               // add an action (button)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

               // show the alert
               self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Warning", message: "Please purchase product", preferredStyle: UIAlertController.Style.alert)

                   // add an action (button)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                   // show the alert
                   self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btnViewCart(_ sender: Any) {
        let defaults = UserDefaults.standard
        if let myarray = defaults.stringArray(forKey: "SavedStringArray")
            
        {
            self.array = myarray as! [String]
        }
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.reloadData()
    }
    
    @IBAction func changeCategory(_ sender: Any) {
        temp.removeAll()
        fillTemp(cat: itemSegment.titleForSegment(at: itemSegment.selectedSegmentIndex)!)
        itemsView.reloadAllComponents()
        itemsView.selectRow(0, inComponent: 0, animated: true)
        itemPrice.text = String(temp[0].itemPrice)
        itemdes.text = String(temp[0].itemdesc)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.array[indexPath.row]
        return cell
    }
}

