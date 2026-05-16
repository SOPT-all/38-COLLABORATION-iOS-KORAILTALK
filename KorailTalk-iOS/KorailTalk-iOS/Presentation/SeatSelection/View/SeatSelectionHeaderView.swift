import UIKit

import SnapKit
import Then

final class SeatSelectionHeaderView: BaseUIView {
    
    // MARK: - Property
    
    private let seatSelectionModel: SeatSelectionModel
    
    // MARK: - UI Components
    
    private lazy var carDropdownView = DropdownView(
        items: seatSelectionModel.carDropdownItems,
        placeholder: seatSelectionModel.currentCarTitle
    )
    
    private let trainInfoStackView = UIStackView()
    private let previousCarButton = UIButton()
    private let trainTextStackView = UIStackView()
    private let trainNameLabel = UILabel()
    private let remainingSeatLabel = UILabel()
    private let nextCarButton = UIButton()
    
    private let vrGuideView = VRGuideView()
    private let seatLegendView = SeatLegendView()
    
    // MARK: - Initializer
    
    init(model: SeatSelectionModel) {
        self.seatSelectionModel = model
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        super.setStyle()
        
        carDropdownView.do {
            $0.isUserInteractionEnabled = false
        }
        
        trainInfoStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalCentering
        }
        
        previousCarButton.do {
            $0.setImage(.icPrevious.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .neutral700
        }
        
        trainTextStackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 4
        }
        
        trainNameLabel.do {
            $0.text = seatSelectionModel.trainTitle
            $0.font = .pretendard(.header2)
            $0.textColor = .neutral900
            $0.textAlignment = .center
        }
        
        remainingSeatLabel.do {
            $0.text = seatSelectionModel.remainingSeatText
            $0.font = .pretendard(.body3)
            $0.textColor = .neutral700
            $0.textAlignment = .center
        }
        
        nextCarButton.do {
            $0.setImage(.icNext.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .primary500
        }
    }
    
    override func setUI() {
        addSubviews(carDropdownView, trainInfoStackView, vrGuideView, seatLegendView)
        
        trainTextStackView.addArrangedSubviews(trainNameLabel, remainingSeatLabel)
        trainInfoStackView.addArrangedSubviews(previousCarButton, trainTextStackView, nextCarButton)
    }
    
    override func setLayout() {
        carDropdownView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(32)
        }
        
        trainInfoStackView.snp.makeConstraints {
            $0.top.equalTo(carDropdownView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(63)
        }
        
        previousCarButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        
        nextCarButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        
        vrGuideView.snp.makeConstraints {
            $0.top.equalTo(trainInfoStackView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(19.5)
            $0.height.equalTo(34)
        }
        
        seatLegendView.snp.makeConstraints {
            $0.top.equalTo(vrGuideView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(14)
        }
    }
}
