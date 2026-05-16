import UIKit

// MARK: - CollectionView CompositionalLayout

enum SeatSelectionCompositionalLayout {
    struct Metric {
        static let `default` = Metric(
            lineSpacing: 8,
            sectionBottomInset: 24,
            headerHeight: 27,
            seatCellSize: CGSize(width: 64, height: 60),
            aisleCellSize: CGSize(width: 44, height: 46)
        )

        let lineSpacing: CGFloat
        let sectionBottomInset: CGFloat
        let headerHeight: CGFloat
        let seatCellSize: CGSize
        let aisleCellSize: CGSize

        var rowContentWidth: CGFloat {
            return seatCellSize.width * 4 + aisleCellSize.width
        }
    }

    static func createLayout(metric: Metric = .default) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, environment in
            let section = NSCollectionLayoutSection(group: makeSeatRowGroup(metric: metric))
            let horizontalInset = max(
                (environment.container.effectiveContentSize.width - metric.rowContentWidth) / 2,
                0
            )

            section.interGroupSpacing = metric.lineSpacing
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: horizontalInset,
                bottom: metric.sectionBottomInset,
                trailing: horizontalInset
            )
            section.boundarySupplementaryItems = [makeHeaderItem(metric: metric)]

            return section
        }
    }
}

// MARK: - Layout Helpers

private extension SeatSelectionCompositionalLayout {
    static func makeSeatRowGroup(metric: Metric) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(metric.rowContentWidth),
            heightDimension: .absolute(metric.seatCellSize.height)
        )

        return NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [
                makeSeatItem(metric: metric),
                makeSeatItem(metric: metric),
                makeAisleItem(metric: metric),
                makeSeatItem(metric: metric),
                makeSeatItem(metric: metric)
            ]
        )
    }

    static func makeSeatItem(metric: Metric) -> NSCollectionLayoutItem {
        return NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(metric.seatCellSize.width),
                heightDimension: .absolute(metric.seatCellSize.height)
            )
        )
    }

    static func makeAisleItem(metric: Metric) -> NSCollectionLayoutItem {
        return NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(metric.aisleCellSize.width),
                heightDimension: .absolute(metric.aisleCellSize.height)
            )
        )
    }

    static func makeHeaderItem(metric: Metric) -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(metric.headerHeight)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}
