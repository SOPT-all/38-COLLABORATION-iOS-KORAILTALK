//
//  DropdownCell.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/12/26.
//

import UIKit

import SnapKit
import Then

final class DropdownCell: UITableViewCell {
    
    // MARK: - Property
    
    static let identifier = "DropdownCell"
    
    // MARK: - UI Components

    private let titleLabel = UILabel()
    
    // MARK: - Initializer

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style, reuseIdentifier: reuseIdentifier
        )

        setStyle()
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    // MARK: - Custom Methods

    private func setStyle() {
        backgroundColor = .white
        selectionStyle = .none

        titleLabel.do {
            $0.font = .pretendard(.caption1)
            $0.textColor = .neutral700
        }
    }

    private func setUI() {
        contentView.addSubview(titleLabel)
    }

    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
    }
    
    // MARK: - Public Methods

    func dataBind(text: String) {
        titleLabel.text = text
    }
    
    func updateTextColor(isSelected: Bool) {
        titleLabel.textColor = isSelected ? .secondary700 : .neutral700
    }
}
