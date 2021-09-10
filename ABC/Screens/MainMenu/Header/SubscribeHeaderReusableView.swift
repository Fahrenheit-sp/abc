//
//  SubscribeHeaderReusableView.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import UIKit

protocol SubscribeHeaderViewDelegate: AnyObject {
    func subscribeHeaderViewDidTap()
}

final class SubscribeHeaderReusableView: UICollectionReusableView {

    private let contentView = UIView().disableAutoresizing()
    private let imageView = UIImageView().disableAutoresizing()
    private let titleLabel = UILabel().disableAutoresizing()
    private lazy var timer: Timer = {
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(shake), userInfo: nil, repeats: true)
    }()

    weak var delegate: SubscribeHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }

    deinit {
        timer.invalidate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.roundCorners(to: 20)

        let insets: UIEdgeInsets = UIDevice.isiPhone
            ? .init(top: 0, left: 16, bottom: 8, right: 16)
            : .init(top: 0, left: 40, bottom: 32, right: 40)
        let contentConstraints = contentView.createConstraintsForEmbedding(in: self, insets: insets)
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

        let imageConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ]

        let labelConstraints = [
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 16)
        ]

        NSLayoutConstraint.activate(contentConstraints + imageConstraints + labelConstraints)
    }

    private func setupUI() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapDetected))

        contentView.backgroundColor = .subscribeBlue
        contentView.addGestureRecognizer(tapRecognizer)

        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.Menu.subscribe.image

        titleLabel.textColor = .black
        titleLabel.font = .current(size: 39)
        titleLabel.text = L10n.Menu.Item.subscribe

        timer.fire()
    }

    @objc private func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 1.0
        animation.values = [-5.0, 5.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
    }

    @objc private func tapDetected() {
        delegate?.subscribeHeaderViewDidTap()
    }
        
}
