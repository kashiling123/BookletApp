//
//  ViewController.swift
//  Booklet
//
//  Created by Mac on 08/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!

    var models = [Model]()
    var models2 = [Model2]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchDataFromBookletAPI()
        fetchDataFromBookletAPI1()
        
        table.delegate = self
        table.dataSource = self
    }
    
    
    func moveOnProductDetail(cIndex: Int) {
        guard let secVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        
        navigationController?.pushViewController(secVC, animated: true)
        
    }
    

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 1 {
            let cell = table.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            
            cell.passDataClosure = { collIndex in
                if let collecIndexP = collIndex {
                    self.moveOnProductDetail( cIndex: collecIndexP)
                }
                
            }
            
            return cell
        }
        let cell2 = table.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell2.bookNameLabel.text = models2[indexPath.row].bookName
        cell2.subtitleLabel.text = models2[indexPath.row].SubTitle
        
        cell2.bookImage.downloadImage2(from: URL(string: models2[indexPath.row].bookImage)!)
        
        
        return cell2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1 {
            return 240
        }
        return 130
    }
    
    
    
    
}


struct Model {
    let title: String
    let image: String
    
    init(title: String,image: String) {
        self.title = title
        self.image = image
    }
}

struct Model2 {
    let bookName: String
    let SubTitle: String
    let bookImage: String
    
    init(bookName: String,SubTitle: String, bookImage: String) {
        self.bookName = bookName
        self.SubTitle = SubTitle
        self.bookImage = bookImage
    }
}


extension ViewController {
    
    func fetchDataFromBookletAPI() {
        
        let urlString = "http://13.235.223.51/bookletapp/public/api/test_api/get-all-menu"
        guard let url = URL(string: urlString) else { return }
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            
            print ("data is \(data)")
            
            if let error = error {
            } else {
                guard let response = response, //as? HTTPURLResponse,
                     // response.statusCode == 200,
                      let data = data  else
                {
                    print("no data")
                    return
                }
                
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                    
                    guard let jsonObject = jsonObject["menu"] as? [[String: Any]] else { return }
              
                    for dictionary in jsonObject {
                        let title = dictionary["title"] as? String
                      
                        let image = dictionary["image"] as? String
                        
                        let productData = Model(title: title ?? "", image: image ?? "")
                        
                        self.models.append(productData)
                        
                        DispatchQueue.main.async {
                            self.table.reloadData()
                        }
                    }
                } catch {
                    print("Error:\(error.localizedDescription)")
                }
            }
            
        }
        dataTask.resume()
    }
}



extension ViewController {
    
    func fetchDataFromBookletAPI1() {
        
        let urlString = "http://13.235.223.51/bookletapp/public/api/test_api/get-all-books"
        guard let url = URL(string: urlString) else { return }
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            
            print ("data is \(data)")
            
            if let error = error {
            } else {
                guard let response = response, //as? HTTPURLResponse,
                     // response.statusCode == 200,
                      let data = data  else
                {
                    print("no data")
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("json not foubd")
                        return
                    }
                
                    
                    
                    guard let jsonObject = jsonObject["books"] as? [[String: Any]] else { return }
                    
                
                    for dictionary in jsonObject {
                        let bookName = dictionary["book_name"] as? String
                        let subTitle = dictionary["subtitle"] as? String
                        let bookImage = dictionary["full_book_image"] as? String
                       
                        let productData = Model2(bookName: bookName ?? "", SubTitle: subTitle ?? "", bookImage: bookImage ?? "")
                        
                        self.models2.append(productData)
                        
                        DispatchQueue.main.async {
                            self.table.reloadData()
                        }
                    }
                } catch {
                    print("Error:\(error.localizedDescription)")
                }
            }
            
        }
        dataTask.resume()
    }
}

extension ViewController {
    
    func fetchDataFromBookletAPI2() {
        
let urlString = "http://13.235.223.51/bookletapp/public/api/test_api/get-all-announcements"
        guard let url = URL(string: urlString) else { return }
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            
            print ("data is \(data)")
            
            if let error = error {
            } else {
                guard let response = response, //as? HTTPURLResponse,
                     // response.statusCode == 200,
                      let data = data  else
                {
                    print("no data")
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("json not foubd")
                        return
                    }
                
                    guard let jsonObject = jsonObject["books"] as? [[String: Any]] else { return }
                    
                    for dictionary in jsonObject {
                        let bookName = dictionary["book_name"] as? String
                        let subTitle = dictionary["subtitle"] as? String
                        let bookImage = dictionary["full_book_image"] as? String
                       
                        let productData = Model2(bookName: bookName ?? "", SubTitle: subTitle ?? "", bookImage: bookImage ?? "")
                        
                        self.models2.append(productData)
                        
                        DispatchQueue.main.async {
                            self.table.reloadData()
                        }
                    }
                } catch {
                    print("Error:\(error.localizedDescription)")
                }
            }
            
        }
        dataTask.resume()
    }
}



extension UIImageView {
    
    func downloadImage2(from url: URL){
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
















/*guard let cell = table.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as? CollectionTableViewCell else {
    return UITableViewCell()
}



/*if indexPath.row == 0 {
    
   
    return cell
}*/
//cell2.bookNameLabel.text = "AAa"
 if indexPath.row < 1 {
     guard let cell2 = table.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else {
         return UITableViewCell()
     }
     cell2.bookNameLabel.text = "AAa"
     //cell2.configure(with: models2)
    
    return cell2
}
return cell*/
