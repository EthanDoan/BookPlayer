//
//  BookCellView.swift
//  BookPlayer
//
//  Created by Florian Pichler on 12.04.18.
//  Copyright © 2018 Tortuga Power. All rights reserved.
//

import Themeable
import UIKit

enum PlaybackState {
    case playing
    case paused
    case stopped
}

enum BookCellType {
    case book
    case playlist
    case file // in a playlist
}

class BookCellView: UITableViewCell {
    @IBOutlet private weak var artworkView: BPArtworkView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var progressTrailing: NSLayoutConstraint!
    @IBOutlet private weak var progressView: ItemProgress!
    @IBOutlet private weak var artworkButton: UIButton!
    @IBOutlet weak var artworkWidth: NSLayoutConstraint!
    @IBOutlet weak var artworkHeight: NSLayoutConstraint!

    var onArtworkTap: (() -> Void)?

    var artwork: UIImage? {
        get {
            return self.artworkView.image
        }
        set {
            self.artworkView.image = newValue

            let ratio = self.artworkView.imageRatio

            self.artworkHeight.constant = ratio > 1 ? 50.0 / ratio : 50.0
            self.artworkWidth.constant = ratio < 1 ? 50.0 * ratio : 50.0
        }
    }

    var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }

    var subtitle: String? {
        get {
            return self.subtitleLabel.text
        }
        set {
            self.subtitleLabel.text = newValue
        }
    }

    var progress: Double {
        get {
            return self.progressView.value
        }
        set {
            self.progressView.value = newValue.isNaN
                ? 0.0
                : newValue
            setAccessibilityLabels()
        }
    }

    var type: BookCellType = .book {
        didSet {
            switch self.type {
            case .file:
                self.accessoryType = .none

                self.progressTrailing.constant = 11.0
            case .playlist:
                self.accessoryType = .disclosureIndicator

                self.progressTrailing.constant = -5.0
            default:
                self.accessoryType = .none

                self.progressTrailing.constant = 29.0 // Disclosure indicator offset
            }
        }
    }

    var playbackState: PlaybackState = PlaybackState.stopped {
        didSet {
            UIView.animate(withDuration: 0.1, animations: {
                self.setPlaybackColors(self.themeProvider.currentTheme)
            })
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
        setUpTheming()
    }

    private func setup() {
        self.accessoryType = .none
        self.selectionStyle = .none
        self.artworkButton.layer.cornerRadius = 4.0
        self.artworkButton.layer.masksToBounds = true
    }

    @IBAction func artworkButtonTapped(_ sender: Any) {
        self.onArtworkTap?()
    }

    func setPlaybackColors(_ theme: ThemeT) {
        switch self.playbackState {
        case .playing:
            self.artworkButton.backgroundColor = theme.tintColor.withAlpha(newAlpha: 0.3)
            self.titleLabel.textColor = theme.tintColor
            self.progressView.pieColor = theme.tintColor
        case .paused:
            self.artworkButton.backgroundColor = theme.tintColor.withAlpha(newAlpha: 0.3)
            self.titleLabel.textColor = theme.tintColor
            self.progressView.pieColor = theme.tintColor
        default:
            self.artworkButton.backgroundColor = UIColor.clear
            self.titleLabel.textColor = theme.titleColor
            self.progressView.pieColor = UIColor(hex: "8F8E94")
        }
    }
}

// MARK: - Voiceover

extension BookCellView {
    private func setAccessibilityLabels() {
        let voiceOverService = VoiceOverService()
        isAccessibilityElement = true
        accessibilityLabel = voiceOverService.bookCellView(type: type,
                                                           title: title,
                                                           subtitle: subtitle,
                                                           progress: progress)
    }
}

extension BookCellView: Themeable {
    func applyTheme(_ theme: ThemeT) {
        self.titleLabel.textColor = theme.titleColor
        self.subtitleLabel.textColor = theme.descriptionColor
        self.backgroundColor = theme.cellColor
        self.setPlaybackColors(theme)
    }
}
