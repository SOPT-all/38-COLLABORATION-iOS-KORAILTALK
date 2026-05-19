//
//  DropdownView.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/12/26.
//

import UIKit

import SnapKit
import Then

final class DropdownView: BaseUIView {
    
    // MARK: - Properties
    
    private var isExpanded = false
    private let placeholder: String
    private let rowHeight: CGFloat = 22
    private let items: [String]
    private var selectedItem: String?
    var onItemSelected: ((String) -> Void)?
    
    // MARK: - UI Components
    
    private let selectButton = UIButton()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let dropdownTableView = UITableView()
    private let containerView = UIView()
    private let dividerView = UIView()
    
    init(items: [String], placeholder: String) {
        self.items = items
        self.placeholder = placeholder
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    // MARK: - Custom Methodsb
    
    override func setStyle() {
        selectButton.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.text = placeholder
            $0.textColor = .neutral700
            $0.font = .pretendard(.caption1)
        }
        
        arrowImageView.do {
            $0.image = UIImage(named: "ic_chevrondown")
            $0.tintColor = .gray
            $0.contentMode = .scaleAspectFit
        }
        
        dropdownTableView.do {
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
            $0.delegate = self
            $0.dataSource = self
            $0.isScrollEnabled = false
            $0.separatorStyle = .singleLine
            $0.separatorColor = .primary100
            $0.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
            
            $0.register(DropdownCell.self, forCellReuseIdentifier: "DropdownCell")
        }
        
        dividerView.do {
            $0.backgroundColor = .primary100
            $0.isHidden = true
        }
        
        containerView.do {
            $0.layer.cornerRadius = 14
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.primary100.cgColor
            $0.clipsToBounds = true
        }
    }
    
    override func setUI() {
        addSubviews(containerView)
        containerView.addSubviews(selectButton, dividerView, dropdownTableView)
        selectButton.addSubviews(titleLabel, arrowImageView)
    }
    
    override func setLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        selectButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(selectButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(selectButton).inset(12)
            $0.width.equalTo(10)
            $0.height.equalTo(6)
        }
        
        dropdownTableView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setAddTarget() {
        selectButton.addTarget(self, action: #selector(selectButtonDidTap), for: .touchUpInside)
        
        selectButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        selectButton.addTarget(self, action: #selector(buttonTouchUp),
            for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    // MARK: - Action
    
    @objc
    private func selectButtonDidTap() {
        isExpanded.toggle()
        
        dropdownTableView.snp.updateConstraints {
            $0.height.equalTo(isExpanded ? CGFloat(items.count) * rowHeight : 0)
        }
        
        dividerView.isHidden = !isExpanded

        dropdownTableView.alpha = isExpanded ? 0 : 1
        
        UIView.animate(withDuration: 0.15) {
            self.dropdownTableView.alpha =
                self.isExpanded ? 1 : 0
        }
        
        arrowImageView.transform = isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
    }
    
    @objc
    private func buttonTouchDown() {
        selectButton.backgroundColor = .primary100
    }

    @objc
    private func buttonTouchUp() {
        UIView.animate(withDuration: 0.15) {
            self.selectButton.backgroundColor = .white
        }
    }
}

extension DropdownView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath) as? DropdownCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        
        cell.dataBind(text: item)
        
        cell.updateTextColor(
            isSelected: item == selectedItem
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = items[indexPath.row]
        
        onItemSelected?(selectedItem ?? "")
        
        titleLabel.text = selectedItem
        titleLabel.textColor = .neutral700
        
        tableView.reloadData()
        
        selectButtonDidTap()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}
