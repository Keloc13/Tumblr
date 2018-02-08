//
//  PhotoViewController.swift
//  Tumblr_Again
//
//  Created by Kevin Nguyen on 2/3/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let DEBUG = true
    
    @IBOutlet weak var TableOutlet: UITableView!
    
    var posts: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableOutlet.delegate = self
        TableOutlet.dataSource = self

        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                let alert = UIAlertController(title: "Alert", message: "Error, something went wrong with the network request. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
               // print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                // TODO: Reload the table view
                self.TableOutlet.reloadData()
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = TableOutlet.indexPath(for: cell) {
            let picture = posts[indexPath.row]
            let photosViewController = segue.destination as! PhotoDetailsViewController
            photosViewController.post = picture
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if DEBUG { print("Entered tableView with URL")}
        let cell = TableOutlet.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        //if DEBUG { print("Reached end of cell and initialized")}
        //cell.textLabel?.text = "This is row \(indexPath.row)"
        let post = posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String: Any]] {
            // 1.
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
            
            cell.Photo.af_setImage(withURL: url!)
        }
        return cell
    }
    
    private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = TableOutlet.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        
        // Configure YourCustomCell using the outlets that you've defined.
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 275.0;//Choose your custom row height
    }
}
