//
//  TrainSearchViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit
import Then

final class TrainSearchViewController: BaseUIViewController{
    private let tableView = UITableView(frame: .zero,style: .plain)
    private let standardButton = FareOptionButton(type: .standard)
    private let specialButton = FareOptionButton(type: .special)
    private let soldoutButton = FareOptionButton(type: .soldout)
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    override func setUI(){
        //self.view.addSubview(tableView)
        self.view.addSubviews(standardButton,specialButton,soldoutButton)
    }
    
    override func setLayout(){
        /*tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }*/
        standardButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.width.height.equalTo(100)
        }
        specialButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(standardButton.snp.bottom).offset(50)
            $0.width.height.equalTo(100)
        }
        soldoutButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(specialButton.snp.bottom).offset(50)
            $0.width.height.equalTo(100)
        }
    }
}
