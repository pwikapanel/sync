//
//  NewsViewModel.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 15/2/21.
//

import Foundation

struct NewsData {
  let text: String
  let message: String
}

class NewsViewModel {
  
  private lazy var placeholder: NewsData = {
    NewsData(
      text: Text.News.Placeholder.text,
      message: ""
    )
  }()
  
  private var appVersion: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
  }
  private var appName: String {
    var name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    name = name.replacingOccurrences(of: " ", with: "-")
    return name
  }
  
  func fetchContent(completion: @escaping (NewsData) -> ()) {
    
    DispatchQueue(label: "News-data-queue").async { [weak self] in
      guard let self = self else { return }
      let time = Int(TimeInterval.epochNow)
      let urlString = Constant.newsUrl + "/\(self.appName)-\(self.appVersion)/\(Text.News.language).txt?\(time)"
      let _url = URL(string: urlString)
      guard let url = _url,
            let string = try? String(contentsOf: url) else {
        completion(self.placeholder)
        return
      }
      //let contents = string.components(separatedBy: .newlines)
      /*guard contents.count > 2 else {
       completion(self.placeholder)
       return
       }
       let text = contents[0]
       let message = contents[1] + "\n" + contents[2]*/
      let text = string
      let message = ""
      completion(NewsData(text: text, message: message))
    }
  }
}
