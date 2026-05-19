import UIKit

import SnapKit
import Then

final class SeatSelectionCollectionView: BaseUIView {

    private enum SeatCollectionItem {
        case seat(Seat)
        case aisle(showsArrow: Bool)
    }

    // MARK: - Property

    private let seatSelectionModel: SeatSelectionModel
    private lazy var seatCollectionItems = makeSeatCollectionItems()
    var selectedSeatCountDidChange: ((Int) -> Void)?

    // MARK: - UI Components

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: SeatSelectionCompositionalLayout.createLayout()
    )

    // MARK: - Initializer

    init(model: SeatSelectionModel) {
        seatSelectionModel = model
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Methods

    override func setStyle() {
        super.setStyle()

        collectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }

        register()
        setDelegate()
    }

    override func setUI() {
        addSubview(collectionView)
    }

    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func updateBottomInset(_ bottomInset: CGFloat) {
        collectionView.contentInset.bottom = bottomInset
        collectionView.verticalScrollIndicatorInsets.bottom = bottomInset
    }

    private func register() {
        collectionView.register(SeatCollectionViewCell.self, forCellWithReuseIdentifier: SeatCollectionViewCell.identifier)
        collectionView.register(AisleCollectionViewCell.self, forCellWithReuseIdentifier: AisleCollectionViewCell.identifier)
        collectionView.register(
            SeatSelectionSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SeatSelectionSectionHeaderView.identifier
        )
    }
}

// MARK: - UICollectionViewDataSource

extension SeatSelectionCollectionView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return seatCollectionItems.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch seatCollectionItems[indexPath.item] {
        case let .seat(seat):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SeatCollectionViewCell.identifier,
                for: indexPath
            ) as? SeatCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.configure(with: seat)
            return cell

        case let .aisle(showsArrow):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AisleCollectionViewCell.identifier,
                for: indexPath
            ) as? AisleCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.configure(showsArrow: showsArrow)
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: SeatSelectionSectionHeaderView.identifier,
                  for: indexPath
              ) as? SeatSelectionSectionHeaderView
        else {
            return UICollectionReusableView()
        }

        headerView.configure(text: carDirectionText)
        return headerView
    }
}

// MARK: - UICollectionViewDelegate

extension SeatSelectionCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case let .seat(seat) = seatCollectionItems[indexPath.item],
              seat.state != .reserved
        else {
            return
        }

        let updatedSeat = Seat(
            number: seat.number,
            state: seat.state == .selected ? .available : .selected,
            hasOutlet: seat.hasOutlet
        )

        seatCollectionItems[indexPath.item] = .seat(updatedSeat)
        collectionView.reloadItems(at: [indexPath])
        selectedSeatCountDidChange?(selectedSeatCount)
    }
}

// MARK: - Private Methods

private extension SeatSelectionCollectionView {
    private func makeSeatCollectionItems() -> [SeatCollectionItem] {
        guard let currentCar = seatSelectionModel.currentCar else {
            return []
        }

        let seatsByNumber = Dictionary(uniqueKeysWithValues: currentCar.seats.map { ($0.number, $0) })
        let rowCount = Int(ceil(Double(currentCar.seats.count) / 4.0))

        return (0 ..< rowCount).flatMap {
            makeSeatRowItems(rowIndex: $0, seatsByNumber: seatsByNumber)
        }
    }

    private func makeSeatRowItems(rowIndex: Int, seatsByNumber: [Int: Seat]) -> [SeatCollectionItem] {
        let seatNumbers = seatNumbers(for: rowIndex)

        return [
            seatCollectionItem(for: seatNumbers[0], seatsByNumber: seatsByNumber),
            seatCollectionItem(for: seatNumbers[1], seatsByNumber: seatsByNumber),
            .aisle(showsArrow: showsAisleArrow(rowIndex: rowIndex)),
            seatCollectionItem(for: seatNumbers[2], seatsByNumber: seatsByNumber),
            seatCollectionItem(for: seatNumbers[3], seatsByNumber: seatsByNumber)
        ]
    }

    private func seatNumbers(for rowIndex: Int) -> [Int] {
        let firstSeatNumber = rowIndex * 4 + 1

        return [
            firstSeatNumber + 2,
            firstSeatNumber + 3,
            firstSeatNumber + 1,
            firstSeatNumber
        ]
    }

    private func seatCollectionItem(for seatNumber: Int, seatsByNumber: [Int: Seat]) -> SeatCollectionItem {
        guard let seat = seatsByNumber[seatNumber] else {
            return .aisle(showsArrow: false)
        }

        return .seat(seat)
    }

    private func showsAisleArrow(rowIndex: Int) -> Bool {
        return rowIndex % 7 >= 2
    }

    var carDirectionText: String {
        let previousCarNumber = max((seatSelectionModel.currentCar?.number ?? 0) - 1, 1)
        return "\(previousCarNumber)호차 방면"
    }

    var selectedSeatCount: Int {
        return seatCollectionItems.reduce(0) { count, item in
            guard case let .seat(seat) = item, seat.state == .selected else {
                return count
            }

            return count + 1
        }
    }
}

private final class SeatSelectionSectionHeaderView: UICollectionReusableView {

    // MARK: - Property

    static let identifier = "SeatSelectionSectionHeaderView"

    // MARK: - UI Components

    private let headerStackView = UIStackView()
    private let leftDashedLineView = DashedLineView()
    private let directionLabel = UILabel()
    private let rightDashedLineView = DashedLineView()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        setStyle()
        setUI()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Methods

    private func setStyle() {
        headerStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 8
        }

        directionLabel.do {
            $0.font = .pretendard(.caption1)
            $0.textColor = .neutral500
            $0.textAlignment = .center
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
    }

    private func setUI() {
        addSubview(headerStackView)
        headerStackView.addArrangedSubviews(leftDashedLineView, directionLabel, rightDashedLineView)
    }

    private func setLayout() {
        headerStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(17)
        }

        leftDashedLineView.snp.makeConstraints {
            $0.width.equalTo(rightDashedLineView)
            $0.height.equalTo(1)
        }

        rightDashedLineView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }

    func configure(text: String) {
        directionLabel.text = text
    }
}

private final class DashedLineView: UIView {

    // MARK: - Property

    private let dashedLayer = CAShapeLayer()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        setStyle()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()

        dashedLayer.frame = bounds
        dashedLayer.path = makeLinePath().cgPath
    }

    // MARK: - Custom Methods

    private func setStyle() {
        backgroundColor = .clear

        dashedLayer.do {
            $0.strokeColor = UIColor.neutral500.cgColor
            $0.lineWidth = 1
            $0.lineDashPattern = [2, 2]
            $0.lineCap = .round
            $0.fillColor = UIColor.clear.cgColor
        }

        layer.addSublayer(dashedLayer)
    }

    private func makeLinePath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.midY))
        return path
    }
}
