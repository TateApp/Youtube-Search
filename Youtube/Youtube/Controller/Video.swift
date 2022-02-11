import UIKit

import YouTubeiOSPlayerHelper
class Video : UIViewController, YTPlayerViewDelegate {
    var _searchItem : SearchItem?
    init(searchItem: SearchItem) {
        super.init(nibName: nil, bundle: nil)
        _searchItem = searchItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
      
        setupPlayer()
    }
    let player = YTPlayerView()
  
    func setupPlayer() {
     
        self.view.addSubview(player)
        player.translatesAutoresizingMaskIntoConstraints = false
        player.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        player.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        player.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        player.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3).isActive = true
        player.load(withVideoId: (_searchItem!.id.videoId ?? ""), playerVars: [
            "playsinline": 1
        
        ])
        player.delegate = self
    }
}
