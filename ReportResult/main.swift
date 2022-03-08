//
//  [프로그래머스] k번 이상 신고당한 유저의 처리 결과를 메일로 공지하기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/92334
//

import Foundation

func solution(_ id_list: [String], _ report: [String], _ k: Int) -> [Int] {
    // 중복을 제외하기 위해 Set으로 설정
    var reports = Dictionary<String, Set<String>>()
    
    // reports의 key: 신고당한 유저의 ID, value: 해당 유저를 신고한 유저의 ID
    report.forEach({
        let reporter = $0.components(separatedBy: " ")[0]
        let reported = $0.components(separatedBy: " ")[1]
        
        var history = (reports[reported] ?? [])
        history.insert(reporter)
        reports[reported] = history
    })
    
    var result = Dictionary<String, [String]>()
    
    // result의 key: 유저의 ID, value: 해당 유저가 신고한 유저 중, k번 이상 신고를 당한 유저
    reports.forEach({ (key, value) in
        if value.count >= k {
            value.forEach({ (reporter) in
                var value = (result[reporter] ?? [])
                value.append(key)
                result[reporter] = value
            })
        }
    })
    
    var count = [Int]()
    
    id_list.forEach({
        count.append(result[$0]?.count ?? 0)
    })
    
    return count
}
