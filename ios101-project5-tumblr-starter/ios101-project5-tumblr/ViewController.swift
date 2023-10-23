//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = [] {
            didSet {
                tableView.reloadData() // Reloads the TableView when posts are set
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
            fetchPosts()
        }
        
        func fetchPosts() {
            let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
            let session = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("❌ Error: \(error.localizedDescription)")
                    return
                }
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                    print("❌ Response error: \(String(describing: response))")
                    return
                }
                
                guard let data = data else {
                    print("❌ Data is NIL")
                    return
                }
                
                do {
                    let blog = try JSONDecoder().decode(Blog.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.posts = blog.response.posts
                        print("✅ We got \(self?.posts.count ?? 0) posts!")
                    }
                    
                } catch {
                    print("❌ Error decoding JSON: \(error.localizedDescription)")
                }
            }
            session.resume()
        }
        
        // MARK: - TableView DataSource Methods
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
            
            let post = posts[indexPath.row]
            cell.configureCell(with: post)
            
            return cell
        }
    }
