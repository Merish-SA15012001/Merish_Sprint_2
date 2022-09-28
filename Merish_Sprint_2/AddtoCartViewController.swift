//
//  AddtoCartViewController.swift
//  Merish_Sprint_2
//
//  Created by Capgemini-DA202 on 9/26/22.
//

import UIKit
import Alamofire
import CoreData

struct detail: Decodable{
    
    enum CodingKeys: String, CodingKey{
        case item = "products"
    }
    let item : [products]
}
struct products: Decodable{
    enum CodingKeys: String, CodingKey{
        case itemtitle = "title"
        case itemDescription = "description"
        case itemthumbnail = "thumbnail"
    }
    let itemtitle: String
    let itemDescription: String
    let itemthumbnail: String
    
}

class ProductDetail: UITableViewCell{
    
    @IBOutlet weak var productimage: UIImageView!
   @IBOutlet weak var cartimage: UIImageView!
    @IBOutlet weak var itemtitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
}

class AddtoCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var AddtocartTable: UITableView!
    var itemName = String()
    var differentItem = [products]()
    var urllink = "https://dummyjson.com/products/category/smartphones"
    //creating context to access persistent container
    let addtocartContext = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        urllink += itemName
       
        callApi()
        // Do any additional setup after loading the view.
    }
    
    @objc func ClickonCart(_ sender: UITapGestureRecognizer){
        
        if duplicateEntry(itemtitle: differentItem[sender.view!.tag].itemtitle){
            let _: NSFetchRequest<AddtoCart> = AddtoCart.fetchRequest()
            do{
            let additem = AddtoCart(context: addtocartContext)
            additem.itemtitle = differentItem[sender.view!.tag].itemtitle
            additem.itemDescription = differentItem[sender.view!.tag].itemDescription
            additem.itemthumbnail = differentItem[sender.view!.tag].itemthumbnail
            do{
                try self.addtocartContext.save()
                print("Item added")
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
       
    }
    }
    func callApi(){
        
        Alamofire.request(urllink, method: .get, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result{
            case .success:
                if let jsondata = response.data{
                    do{
                        let Response = try JSONDecoder().decode(detail.self, from: jsondata)
                        self.differentItem.append(contentsOf: Response.item)
                        DispatchQueue.main.async {
                            self.AddtocartTable.dataSource  = self
                            self.AddtocartTable.delegate = self
                            self.AddtocartTable.reloadData()
                        }
                    }
                    catch let error{
                        print(error.localizedDescription)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    func duplicateEntry(itemtitle: String) -> Bool{
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return(0 != 0)}
        let context = appdelegate.persistentContainer.viewContext
        let req = AddtoCart.fetchRequest()
        req.predicate = NSPredicate(format: "%K == %@", argumentArray: ["itemtitle", itemtitle])
        
        //creating variable of NSManagedObject
        
        var result: [NSManagedObject] = []
        do{
            result = try context.fetch(req)
            
            if result.count == 1{
                print("Already added")
            }
        }
        catch let error{
            print(error.localizedDescription)
        }
        
        return result.count == 0
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return differentItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddtocartTable.dequeueReusableCell(withIdentifier: "ProductDetail", for: indexPath) as! ProductDetail
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ClickonCart(_:)))
        cell.productimage.loadimage(urlAddress: differentItem[indexPath.row].itemthumbnail)
        cell.itemtitle.text = differentItem[indexPath.row].itemtitle
        cell.itemDescription.text = differentItem[indexPath.row].itemDescription
        cell.cartimage.tag = indexPath.row
        cell.cartimage.addGestureRecognizer(tapGesture)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cartvc = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(cartvc, animated: true)
        
    }
}
extension UIImageView{
    func loadimage(urlAddress: String){
        guard let url = URL(string: urlAddress) else {
            return
        }
        DispatchQueue.main.async{ [weak self] in
            if let img = try? Data(contentsOf: url){
                if let loadimg = UIImage(data: img){
                self?.image = loadimg
            }
        }
    }
}
}
