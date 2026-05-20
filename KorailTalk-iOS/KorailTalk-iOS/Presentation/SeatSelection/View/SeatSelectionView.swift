import SnapKit
import UIKit

final class SeatSelectionView: BaseUIView {
    // MARK: - Property
    
    var selectedSeatsDidChange: (([Seat]) -> Void)? {
        didSet {
            seatSelectionCollectionView.selectedSeatsDidChange = selectedSeatsDidChange
        }
    }
    
    // MARK: - UI Components
    
    private let headerView: SeatSelectionHeaderView
    private let seatSelectionCollectionView: SeatSelectionCollectionView
    
    // MARK: - Initializer
    
    init(model: SeatSelectionModel) {
        headerView = SeatSelectionHeaderView(model: model)
        seatSelectionCollectionView = SeatSelectionCollectionView(model: model)
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    override func setUI() {
        addSubviews(headerView, seatSelectionCollectionView)
    }
    
    override func setLayout() {
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(190)
        }
        
        seatSelectionCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(24)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func updateSeatCollectionBottomInset(_ bottomInset: CGFloat) {
        seatSelectionCollectionView.updateBottomInset(bottomInset)
    }
    
    func configure(model: SeatSelectionModel) {
        headerView.configure(model: model)
        seatSelectionCollectionView.configure(model: model)
    }
}
