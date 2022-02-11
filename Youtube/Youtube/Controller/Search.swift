//
//  ViewController.swift
//  Youtube
//
//  Created by Tate Wrigley on 11/02/2022.
//

import UIKit
import YouTubeiOSPlayerHelper

class Search: UIViewController, UITextFieldDelegate {
    var searchTimer  : Timer?
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text != "" {
            UIView.animate(withDuration: 0.5, animations: {
                self.clearButton.alpha = 1
                self.tableView.alpha = 1
            })
            welcomeText.alpha = 0
       
        result = []
        tableView.reloadData()
        searchTimer?.invalidate()
        activity.startAnimating()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [self] timer in
            activity.stopAnimating()
            fetchData(query: textField.text!)
            
        })
        } else{
            UIView.animate(withDuration: 0.5, animations: {
                self.clearButton.alpha = 0
                self.tableView.alpha = 0
            })
            result = []
            tableView.reloadData()
            welcomeText.alpha = 0
        }
    }
    let tableView = UITableView()
    let searchBar = UITextField()
    let searchBackBar = UIView()
    let searchBarSeperator = UIView()
    
    var result = [SearchItem]()
    let activity = UIActivityIndicatorView()
    
    let apiReturnedNoResults = UILabel()
    
    let welcomeText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true
        
        self.view.backgroundColor = .init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        setupSearchBar()
        
    setupWelcomeMessage()
        
        setupTableView()
    
        self.view.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.widthAnchor.constraint(equalToConstant: 200).isActive = true
        activity.heightAnchor.constraint(equalToConstant: 200).isActive = true
        activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activity.color = .white
        
    }
    let clearButton = UIButton(type: .system)
    func setupSearchBar() {
        
        let dictionary : [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor : UIColor.white
            
        ]
        let _dictionary : [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor : UIColor.init(red: 112/255, green: 112/255, blue: 112/255, alpha: 112/255)
            
        ]
        self.view.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        clearButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        clearButton.alpha = 0
        
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.clearButton.leadingAnchor, constant: -10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.textColor = .white
        searchBar.delegate = self
 
       
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search Youtube", attributes: _dictionary)
      
        clearButton.setAttributedTitle(NSAttributedString(string: "X", attributes: dictionary), for: .normal)
        clearButton.addTarget(self, action: #selector(clearButtonPressed(sender:)), for: .touchUpInside)
        self.view.addSubview(searchBarSeperator)
        searchBarSeperator.translatesAutoresizingMaskIntoConstraints = false
        searchBarSeperator.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchBarSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        searchBarSeperator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchBarSeperator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchBarSeperator.backgroundColor = UIColor.init(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
    }
    @objc func clearButtonPressed(sender: UIButton) {
        searchBar.text = ""
       
    }
    func setupWelcomeMessage() {
        self.view.addSubview(welcomeText)
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        welcomeText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        welcomeText.heightAnchor.constraint(equalToConstant: 200).isActive = true
        welcomeText.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        welcomeText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        welcomeText.text =
"""
Welcome To Youtube Search

Use The Search Functionality To Access Youtube API!
"""
        welcomeText.font = .boldSystemFont(ofSize: 15)
        welcomeText.textColor = .white
        welcomeText.textAlignment = .center
        welcomeText.numberOfLines = .max
    }
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBarSeperator.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.backgroundColor =  .init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(YoutubeCell.self, forCellReuseIdentifier: YoutubeCell.identifer)
        tableView.alpha = 0
    }
   
let query = ""
    func fetchData(query: String) {
        let urlString = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=\(query.replacingOccurrences(of: " ", with: ""))&key=AIzaSyC83FzGbK0zNIcOJu5ft0SyQoJUxmEZuJg"
        result = [SearchItem]()
        
       
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            
            guard let _data = data , error == nil else {
           
                return
              
            }
    
            do {
                let jsonResult = try JSONDecoder().decode(SearchResponse.self, from: _data)
                DispatchQueue.main.async {
                   
                    self.result = jsonResult.items
                    self.tableView.reloadData()
//                    self.collectionView.reloadData()
                }
             
            }catch {
                print(error)
              
            }
        }
        task.resume()
    }

}
extension Search: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YoutubeCell.identifer, for: indexPath) as! YoutubeCell
        cell.setup(searchItem: result[indexPath.row])
//        cell.textLabel!.text = result[indexPath.row].snippet.title
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Video(searchItem: result[indexPath.row])
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        320
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result.count
    }
    
    
    
}
