//
//  ViewController.swift
//  Covid19
//
//  Created by sowah on 4/5/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var innerItems = [InnerItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return innerItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let listOfItems = innerItems[indexPath.row]
        cell.countryName.text = listOfItems.country 
        cell.recoveredLabel.text = String(listOfItems.cases.recovered)
        cell.deathLabel.text = String(listOfItems.deaths.total)
        cell.flagImage.image = UIImage(named: listOfItems.country.countryNameToCodeConvert(name: listOfItems.country))

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let vc = segue.destination as! DetailViewController
                vc.countryName = innerItems[indexPath.row].country
                vc.detailItem = innerItems[indexPath.row]
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    @IBAction func refreshButtonTap(_ sender: Any) {
        innerItems.removeAll()
        loadJson()
        tableView.reloadData()
    }
    
    // error message alert
    func errorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            print("something...")
            self.loadJson()
        }))
        self.present(alert, animated: true)
    }
    
    // fetching data 
    func loadJson() {
        ProgressHUD.show("Wait", interaction: false)
        
        let headers = [
            "x-rapidapi-host": "covid-193.p.rapidapi.com",
            "x-rapidapi-key": "de28e0d3a5msh2fbf1eddd367ac3p1139cajsnb66181fca8f9"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://covid-193.p.rapidapi.com/statistics")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                // do something when error appear.
                
                DispatchQueue.main.async {
                    self.errorMessage(message: error!.localizedDescription)
                    
                }
                return
                
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
            }
            
            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode(MyPost.self, from: data!)
                //try JSONSerialization.jsonObject(with: data!, options: [])
                self.innerItems = json.response.sorted {$0.deaths.total > $1.deaths.total}
             
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                ProgressHUD.showSuccess("Success", interaction: false)
                
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.errorMessage(message: error.localizedDescription)
                }
            }
        })
        dataTask.resume()
        
    }
}



