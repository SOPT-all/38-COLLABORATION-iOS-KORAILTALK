import UIKit

import SnapKit

final class SeatSelectionView: BaseUIView {

    // MARK: - Property

    var selectedSeatCountDidChange: ((Int) -> Void)? {
        didSet {
            seatSelectionCollectionView.selectedSeatCountDidChange = selectedSeatCountDidChange
        }
    }

    // MARK: - UI Components

    private let headerView: SeatSelectionHeaderView
    private let seatSelectionCollectionView: SeatSelectionCollectionView

    // MARK: - Initializer

    init(model: SeatSelectionModel) {
        self.headerView = SeatSelectionHeaderView(model: model)
        self.seatSelectionCollectionView = SeatSelectionCollectionView(model: model)
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
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
}
