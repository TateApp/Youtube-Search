//
//  SearchResponse.swift
//  Youtube
//
//  Created by Tate Wrigley on 11/02/2022.
//

import Foundation

struct SearchResponse :Codable {
    let items : [SearchItem]
}
struct SearchItem : Codable {
    let kind: String
    let etag: String
    let id: SearchID
    let snippet: SearchSnippet
    
}
struct SearchID: Codable {
//    let kind : String
    let videoId : String?
    
}
struct SearchSnippet : Codable {
    let publishedAt: String
    let channelId : String
    let title : String
    let description: String
    let thumbnails : SearchThumbnail
    let channelTitle: String
    let liveBroadcastContent: String
    let publishTime : String
    
}
struct SearchThumbnail : Codable {
    let `default` : SearchDefault
    let medium : SearchMedium
    let high : SearchHigh
}
struct SearchDefault: Codable {
    let url : String
}
struct SearchMedium: Codable {
    let url : String
}
struct SearchHigh: Codable {
    let url: String
}
//{
//        "kind":"youtube#searchResult",
//        "etag":"rh5ab_L1Ks2DMFpqyNaDWKJhQa8",
//        "id":{
//           "kind":"youtube#video",
//           "videoId":"VafTMsrnSTU"
//        },
//        "snippet":{
//           "publishedAt":"2022-01-07T20:00:09Z",
//           "channelId":"UCF_fDSgPpBQuh1MsUTgIARQ",
//           "title":"The Weeknd - Sacrifice (Official Music Video)",
//           "description":"EPILEPSY WARNING ******** *****EPILEPSY WARNING ******** *****EPILEPSY WARNING ******** Official music video for The ...",
//           "thumbnails":{
//              "default":{
//                 "url":"https://i.ytimg.com/vi/VafTMsrnSTU/default.jpg",
//                 "width":120,
//                 "height":90
//              },
//              "medium":{
//                 "url":"https://i.ytimg.com/vi/VafTMsrnSTU/mqdefault.jpg",
//                 "width":320,
//                 "height":180
//              },
//              "high":{
//                 "url":"https://i.ytimg.com/vi/VafTMsrnSTU/hqdefault.jpg",
//                 "width":480,
//                 "height":360
//              }
//           },
//           "channelTitle":"TheWeekndVEVO",
//           "liveBroadcastContent":"none",
//           "publishTime":"2022-01-07T20:00:09Z"
//        }
//     },
