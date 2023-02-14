//
//  ProfileViewController.swift
//  Core Data
//
//  Created by Mac on 14/02/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: The image model properties
    lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        img.image = UIImage(named: "night_image")
        return img
    }()
    
    // MARK: The title label model properties
    lazy var profileName: UILabel = {
        let label = UILabel()
        label.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Agbachi Chidiogo M"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profileEmail: UIButton = {
        let email = UIButton()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.setTitle("chidiogomelvis@gmail.com", for: .normal)
        email.setTitleColor(.blue, for: .normal)
        return email
    }()
    
    lazy var home: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Home", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        view.backgroundColor = .white
    }
    
    @objc func homeButtonTapped() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    func setUpViews() {
        view.addSubview(profileImage)
        view.addSubview(profileName)
        view.addSubview(profileEmail)
        view.addSubview(home)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            
            profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            profileName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            
            profileEmail.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 10),
            profileEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            
            home.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            home.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
        ])
    }
    
    
}
