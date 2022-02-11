import UIKit


class YoutubeCell : UITableViewCell {
    
    static let identifer = "YoutubeCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    let customImage = CustomImageView()
    let videoTitle = UILabel()
    let bottomLabel = UILabel()

    
    func setup(searchItem: SearchItem) {
        self.contentView.addSubview(customImage)
        customImage.translatesAutoresizingMaskIntoConstraints = false
        customImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        customImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        customImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        customImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        customImage.loadImage(with: searchItem.snippet.thumbnails.high.url)
        customImage.contentMode = .scaleAspectFill
        customImage.backgroundColor = .clear
        
        self.contentView.addSubview(videoTitle)
        videoTitle.translatesAutoresizingMaskIntoConstraints = false
        videoTitle.topAnchor.constraint(equalTo: customImage.bottomAnchor, constant: 40).isActive = true
        videoTitle.leadingAnchor.constraint(equalTo: customImage.leadingAnchor, constant: 10).isActive = true
        videoTitle.trailingAnchor.constraint(equalTo: customImage.trailingAnchor, constant: -10).isActive = true
        videoTitle.numberOfLines = 2
        videoTitle.font = .systemFont(ofSize: 12)
        videoTitle.text = searchItem.snippet.title
        videoTitle.textColor = .white
        
        self.contentView.addSubview(bottomLabel)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: 10).isActive = true
        bottomLabel.leadingAnchor.constraint(equalTo: videoTitle.leadingAnchor).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: videoTitle.trailingAnchor).isActive = true
        bottomLabel.numberOfLines = 2
        bottomLabel.font = .systemFont(ofSize: 12)
        bottomLabel.text = "\(searchItem.snippet.channelTitle) - \(searchItem.snippet.publishTime)"
        bottomLabel.textColor = .systemGray3
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
