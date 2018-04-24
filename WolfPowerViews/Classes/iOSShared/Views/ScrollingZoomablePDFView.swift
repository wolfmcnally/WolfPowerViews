//
//  ScrollingZoomablePDFView.swift
//  WolfPowerViews
//
//  Created by Wolf McNally on 3/8/18.
//

import WolfCore

public class ScrollingZoomablePDFView: View {
    public var pdf: PDF? {
        get { return contentView.pdf }
        set { contentView.pdf = newValue }
    }

    public var minimumZoomScale: CGFloat = 0.5 { didSet { syncZoom() } }
    public var maximumZoomScale: CGFloat = 8.0 { didSet { syncZoom() } }
    public var levelsOfDetail = 4 { didSet { syncZoom() } }
    public var levelsOfDetailBias = 3 { didSet { syncZoom() } }

    public private(set) lazy var contentView = TiledPDFView() • {
        $0.levelsOfDetail = self.levelsOfDetail
        $0.levelsOfDetailBias = self.levelsOfDetailBias
    }

    public private(set) lazy var scrollView = ScrollView() • {
        $0.delegate = self
        $0.minimumZoomScale = self.minimumZoomScale
        $0.maximumZoomScale = self.maximumZoomScale
    }

    public override func setup() {
        self => [
            scrollView => [
                contentView
            ]
        ]

        scrollView.constrainFrameToFrame()
        contentView.constrainFrameToFrame()
        syncZoom()
    }

    private func syncZoom() {
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = maximumZoomScale
        contentView.levelsOfDetail = levelsOfDetail
        contentView.levelsOfDetailBias = levelsOfDetailBias
    }
}

extension ScrollingZoomablePDFView: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }

    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    }
}
