//
//  ContentView.swift
//  CommitGarden
//
//  Created by hyunho lee on 6/22/23.
//

import SwiftUI
import SwiftSoup

struct ContentView: View {
    @State private var username: String? = "m1zz"
    @State var commitData: Data?
    @State private var myContributes: [ContributeData] = []
    @State private var serialCommitCount: Int = 0
    @State private var mystreaks: ContributeData = ContributeData(level: 0, weekend: "", date: "")
    @State private var commitLevel:[Int] = []
    
    
    var body: some View {
        ZStack {
            
            List {
                ForEach(myContributes, id: \.self) { item in
                    HStack {
                        Text("test")
                        Text("test")
                        Text("test")
                    }
                }
            }
            .onAppear {
                guard let targetURL = URL(string: "https://github.com/users/m1zz/contributions") else { return }
                //dataTask(with: targetURL)
            }
            .onChange(of: myContributes) { oldValue, newValue in
                for item in myContributes {
                    commitLevel.append(item.level)
                }
                
                print("commitLevel", commitLevel)
            }
            
            VStack {
                TypoView()
                    .frame(width: 200,
                           height: 30,
                           alignment: .center)
                    .ignoresSafeArea()
                Spacer()
            }
            
            
        }
        
    }
    
    func dataTask(with url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print("completed data : \(String(data: data!, encoding: .utf8))")
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode),
                  let mimeType = response.mimeType,
                  mimeType == "text/html" else {
                return }
            DispatchQueue.main.async {
                commitData = data
                guard let data = commitData,
                      let html = String(data: data, encoding: .utf8)
                else { return }
                //print(data.count, commitData?.count)
                mystreaks = parseHtmltoDataForCount(html: html)
                //print(mystreaks.date, mystreaks.count)
                myContributes = parseHtmltoData(html: html)
            }
        }.resume()
    }
    
    private func parseHtmltoDataForCount(html: String) -> ContributeData {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let rects: Elements = try doc.getElementsByTag(ParseKeys.rect)
            //print(doc)
            let days: [Element] = rects.array().filter { $0.hasAttr(ParseKeys.date) }
            let count = days.suffix(Consts.fetchStreak)
            
            var contributeLastDate = count.map(mapFunction)
            
            contributeLastDate.sort{ $0.date > $1.date }
            print("count", contributeLastDate.count)
            for index in 0 ..< contributeLastDate.count {
                print("index",index,
                      "date",contributeLastDate[index].date,
                      "count",contributeLastDate[index].level,
                      "weekend",contributeLastDate[index].weekend)
                //                if contributeLastDate[index].count == .zero, index != 0 {
                //                    self.serialCommitCount = index
                //                    return contributeLastDate[index]
                //                }
                if index == (contributeLastDate.count - 1) {
                    return ContributeData(
                        level: 1000,
                        weekend: contributeLastDate[index].weekend,
                        date: contributeLastDate[index].date
                    )
                }
            }
            return ContributeData(level: 0, weekend: "", date: "")
        } catch {
            return ContributeData(level: 0, weekend: "", date: "")
        }
    }
    
    private func parseHtmltoData(html: String) -> [ContributeData] {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let rects: Elements = try doc.getElementsByTag(ParseKeys.rect)
            let days: [Element] = rects.array().filter { $0.hasAttr(ParseKeys.date) }
            
            let weekend = serialCommitCount == 0 ? days.suffix(Consts.fetchCount) : days.suffix(serialCommitCount)
            
            var contributeDataList = weekend.map(mapFunction)
            contributeDataList.sort{ $0.date > $1.date }
            return contributeDataList
            
        } catch {
            return []
        }
    }
    
    private func mapFunction(ele : Element) -> ContributeData {
        guard let attr = ele.getAttributes() else { return ContributeData(level: 0, weekend: "", date: "") }
        let date: String = attr.get(key: ParseKeys.date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        let dateForWeekend = dateFormatter.date(from: date)
        
        //print("dateForWeekend", dateForWeekend)
        
        guard let weekend = dateForWeekend?.dayOfWeek() else { return ContributeData(level: 0, weekend: "", date: "")}
        guard let count = Int(attr.get(key: ParseKeys.contributionLevel)) else { return ContributeData(level: 0, weekend: "", date: "")}
        
        return ContributeData(level: count, weekend: weekend, date: date)
    }
    
    //    func fetchContributionsByUserame(by username: String) {
    //        guard let targetURL = URL(string: "https://github.com/users/m1zz/contributions") else { return }
    //        receiveData = Data()
    //        let myNetworkManager = MyNetworkManager()
    //        myNetworkManager.dataTask(with: targetURL)
    //    }
}

#Preview {
    ContentView()
}
