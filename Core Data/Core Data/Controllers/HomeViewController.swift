//
//  HomeViewController.swift
//  Core Data
//
//  Created by Mac on 14/02/2023.
//

import UIKit
import AVFoundation
import CoreData

//MARK: - Home ViewController Property Objects
class HomeViewController: UIViewController {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var fruits: [Fruits]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.layer.cornerRadius = 15
        btn.tintColor = .blue
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.separatorColor = .clear
        return table
    }()
    
    lazy var playButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "pause"), for: .normal)
        btn.layer.cornerRadius = 15
        btn.tintColor = .blue
        return btn
    }()
    
    lazy var profile: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Profile", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        playAudioUrl()
        fetchFruits()
        playAudio()
    }
    
    func playAudio() {
        DispatchQueue.main.async {
            self.player?.play()
        }
    }
    
    //MARK: - This function creates a fruit object by uialert functionality
    @objc func addButtonTapped()
    {
        let alert = UIAlertController(title: "Add Fruit", message: "What is the name of the fruit?", preferredStyle: .alert)
        alert.addTextField()
        
        let submitBtn = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            //MARK: - create an object
            let newFruit = Fruits(context: self.context)
            newFruit.name = textField.text
            newFruit.type = "Ripe"
            newFruit.number = 10
            
            //MARK: - save the data
            do {
                try self.context.save()
            }
            catch {
                
            }
            //MARK: - refectch the data
            self.fetchFruits()
        }
        
        alert.addAction(submitBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - This function fetches the data from core data and presents on the tableview
    
    func fetchFruits() {
        // fetch the data from core data to display in the tableview
        do {
            self.fruits = try context.fetch(Fruits.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        catch {
            
        }
        
    }
    
    func playAudioUrl() {
        let url = URL(string: "https://www.xclusiveloaded.com/wp-content/uploads/2019/04/Master_KG_ft_Zanda_Zakuza_-_Skeleton_Move.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
    }
    
    @objc func profileButtonTapped() {
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
