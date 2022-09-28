//
//  CartViewController.swift
//  Merish_Sprint_2
//
//  Created by Capgemini-DA202 on 9/26/22.
//

import UIKit
import CoreData

class Cartcheckout: UITableViewCell{
    
    @IBOutlet weak var cartcheckoutimage: UIImageView!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    
}
class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var cartProduct = [AddtoCart]()
    let cartcontext = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var cartTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cartitem()
        cartTable.delegate = self
        cartTable.dataSource = self
    }
    
// fetch data from the coredata
    func cartitem(){
       
        let request: NSFetchRequest<AddtoCart> = AddtoCart.fetchRequest()
    
        do{
            let cart = try cartcontext.fetch(request)
            cartProduct = cart
            
            DispatchQueue.main.async {  
                self.cartTable.delegate = self
                self.cartTable.dataSource = self
                self.cartTable.reloadData()
            }
        }
        catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    @objc func clickedoncart(_ sender: UITapGestureRecognizer){
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProduct.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "Cartcheckout", for: indexPath) as! Cartcheckout
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedoncart(_:)))
        let item = cartProduct[indexPath.row]
        cell.productimage.loadimage(urlAddress: item.itemthumbnail!)
        cell.productTitle.text = item.itemtitle
        cell .productDescription.text = item.itemDescription
        cell.cartcheckoutimage.addGestureRecognizer(tapGesture)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cartvc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.pushViewController(cartvc, animated: true)
}
}
