//
//  TiledPDFView.swift
//  WolfPowerViews
//
//  Created by Wolf McNally on 3/8/18.
//

import WolfCore

public class TiledPDFView: View {
    public var pdf: PDF? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    var levelsOfDetail: Int {
        get { return tiledLayer.levelsOfDetail }
        set { tiledLayer.levelsOfDetail = newValue }
    }

    var levelsOfDetailBias: Int {
        get { return tiledLayer.levelsOfDetailBias }
        set { tiledLayer.levelsOfDetailBias = newValue }
    }

    var drawTileBounds = false
    var drawImageBounds = false

    override public class var layerClass: AnyClass { return CATiledLayer.self }

    private var tiledLayer: CATiledLayer { return layer as! CATiledLayer }

    override public func setup() {
        super.setup()

        tiledLayer • {
            $0.tileSize = CGSize(width: 512, height: 512)
            $0.delegate = self
            $0.levelsOfDetail = 4
            $0.levelsOfDetailBias = 3
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        tiledLayer.setNeedsDisplay()
    }

    public override var intrinsicContentSize: CGSize {
        return pdf?.getSize() ?? .zero
    }

    // CALayerDelegate
    override public func draw(_ layer: CALayer, in context: CGContext) {
        guard let image = pdf else { return }
        let tiledLayer = layer as! CATiledLayer
        let tileSize = tiledLayer.tileSize
        let scale = context.ctm.a
        let imageSize = image.getSize()
        let scaledImageSize = imageSize * scale
        let x = context.ctm.tx
        let y = context.ctm.ty

        let invCTM = context.ctm.inverted()
        context.concatenate(invCTM)
        flipContext(context, height: tileSize.height)

        drawInto(context) { context in
            context.translateBy(x: x, y: tileSize.height - y)

            drawInto(context) { context in
                flipContext(context, height: scaledImageSize.height)
                image.drawImage(into: context, size: scaledImageSize)
            }

            guard drawImageBounds else { return }
            drawCrossedBox(into: context, size: scaledImageSize, color: .red, lineWidth: 3, showOriginIndicators: true)
        }

        guard drawTileBounds else { return }
        drawInto(context) { context in
            drawCrossedBox(into: context, size: tileSize, color: .white, lineWidth: 1, showOriginIndicators: true)
        }
    }
}
