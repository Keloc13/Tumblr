//
//  PhotoDetailsViewController.swift
//  Tumblr_Again
//
//  Created by Kevin Nguyen on 2/7/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var post: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post{
            let photos = post["photos"] as! [[String: Any]]
            let caption = post["summary"] as! String
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            photoImageView.af_setImage(withURL: url!)
            descriptionView.text = caption
            descriptionView.sizeToFit()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
