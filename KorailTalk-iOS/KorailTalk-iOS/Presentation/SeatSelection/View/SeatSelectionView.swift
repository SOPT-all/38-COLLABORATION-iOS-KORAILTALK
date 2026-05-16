import UIKit

import SnapKit
import Then

final class SeatSelectionView: BaseUIView {
    
    // MARK: - UI Components
    
    private let headerView = SeatSelectionHeaderView()
    private lazy var seatCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        super.setStyle()
        
        seatCollectionView.do {
            $0.backgroundColor = .yellow // TODO :: change to clear
        }
    }
    
    override func setUI() {
        addSubviews(headerView, seatCollectionView)
    }
    
    override func setLayout() {
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        seatCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(12)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
