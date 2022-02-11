//
//  DetailsViewController.swift
//  TableView_test
//
//  Created by user214346 on 2/4/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelNew: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        url()
        // Do any additional setup after loading the view.
    }
    
    func url(){
        // Obtain Reference to Shared Session
            let sharedSession = URLSession.shared

            if let url = URL(string: "https://goo.gl/wV9G4I") {
                // Create Request
                let request = URLRequest(url: url)

                // Create Data Task
                let dataTask = sharedSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                    if let data = data, let image = UIImage(data: data)
                    {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                })

                dataTask.resume()
            }
        
    }
    
    /*
    queue = NSOperationQueue()

        queue.addOperationWithBlock { () -> Void in
            
            let img1 = Downloader.downloadImageWithURL(imageURLs[0])

            NSOperationQueue.mainQueue().addOperationWithBlock(
            {
                self.imageView1.image = img1
            })
        }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

