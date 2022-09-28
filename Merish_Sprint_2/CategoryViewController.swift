//
//  CategoryViewController.swift
//  Merish_Sprint_2
//
//  Created by Capgemini-DA202 on 9/26/22.
//

import UIKit
import Alamofire

var Index = 0
class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var categorytable: UITableView!
    
    var catArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonData()
        // Do any additional setup after loading the view.
    }
    
    func jsonData(){
        let url = "https://dummyjson.com/products/categories"
        Alamofire.request(url).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                let data = response.result.value as! [String]?
                self.catArray = data!
                self.categorytable.reloadData()
                
            case .failure(let error):
                print("Error occured \(error.localizedDescription)")
            }
        }
    }
   


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categorytable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = catArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddtoCartViewController") as? AddtoCartViewController{
            self.navigationController?.pushViewController(vc, animated: true)
            Index = indexPath.row
            categorytable.deselectRow(at: indexPath, animated: true)
            
        }    }
}
