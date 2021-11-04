//
//  DrawView.swift
//  ABC
//
//  Created by Игорь Майсюк on 2.11.21.
//

import UIKit

final class DrawView: UIView {

    private let path = UIBezierPath()
    private let maskLayer = CALayer()
    private let drawLayer = CAShapeLayer()

    var drawColor: UIColor = .red
    var letter: String = "a"

    var onImageGenerated: ((UIImage?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        maskLayer.frame = bounds
        drawLayer.frame = bounds
    }

    private func setupUI() {
        backgroundColor = .clear

        layer.mask = maskLayer
        layer.addSublayer(drawLayer)

        layer.contents = ImageAsset(name: letter).image.cgImage
        layer.contentsGravity = .resizeAspect

        maskLayer.contentsGravity = .resizeAspect
        maskLayer.contents = ImageAsset(name: letter).image.cgImage

        drawLayer.strokeColor = drawColor.cgColor
        drawLayer.lineWidth = 75
        drawLayer.fillColor = UIColor.clear.cgColor
        path.lineCapStyle = .round
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        path.move(to: touch.location(in: self))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        path.addLine(to: touch.location(in: self))
        path.stroke()
        drawLayer.path = path.cgPath
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let rendererFormat = UIGraphicsImageRendererFormat.default()
        rendererFormat.opaque = isOpaque
        let renderer = UIGraphicsImageRenderer(size: bounds.size, format: rendererFormat)

        let snapshotImage = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.onImageGenerated?(snapshotImage)
        }

    }
}

extension UIImage {
    var averageColor: UIColor? {
            // convert our image to a Core Image Image
            guard let inputImage = CIImage(image: self) else { return nil }

            // Create an extent vector (a frame with width and height of our current input image)
            let extentVector = CIVector(x: inputImage.extent.origin.x,
                                        y: inputImage.extent.origin.y,
                                        z: inputImage.extent.size.width,
                                        w: inputImage.extent.size.height)

            // create a CIAreaAverage filter, this will allow us to pull the average color from the image later on
            guard let filter = CIFilter(name: "CIAreaAverage",
                                      parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
            guard let outputImage = filter.outputImage else { return nil }

            // A bitmap consisting of (r, g, b, a) value
            var bitmap = [UInt8](repeating: 0, count: 4)
            let context = CIContext(options: [.workingColorSpace: kCFNull!])

            // Render our output image into a 1 by 1 image supplying it our bitmap to update the values of (i.e the rgba of the 1 by 1 image will fill out bitmap array
            context.render(outputImage,
                           toBitmap: &bitmap,
                           rowBytes: 4,
                           bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                           format: .RGBA8,
                           colorSpace: nil)

            // Convert our bitmap images of r, g, b, a to a UIColor
            return UIColor(red: CGFloat(bitmap[0]) / 255,
                           green: CGFloat(bitmap[1]) / 255,
                           blue: CGFloat(bitmap[2]) / 255,
                           alpha: CGFloat(bitmap[3]) / 255)
        }
}

private struct Line {
    let startPoint: CGPoint
    let color: UIColor
    private(set) var points: [CGPoint]

    init(startPoint: CGPoint, color: UIColor) {
        self.startPoint = startPoint
        self.color = color
        self.points = [startPoint]
    }

    mutating func add(_ point: CGPoint) {
        points.append(point)
    }
}
