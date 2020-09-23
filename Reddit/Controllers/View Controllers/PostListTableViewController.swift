//
//  PostListTableViewController.swift
//  Reddit
//
//  Created by LAURA JELENICH on 9/23/20.
//

import UIKit

class PostListTableViewController: UITableViewController {

    //MARK: - Properties
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = posts[indexPath.row]
        cell.post = post
        cell.delegate = self
        return cell
    }

    //MARK: - Helpers
    func fetchPosts() {
        PostController.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(locializedError: error)
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - Extension
extension PostListTableViewController: PresentErrorToUserDelegate {
    func presentError(error: LocalizedError) {
        //DispatchQueue could go here
        self.presentErrorToUser(locializedError: error)
    }
}
