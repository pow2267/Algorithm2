//
//  [프로그래머스] LRU 캐시를 이용해 데이터베이스 처리 시간 구하기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/17680
//

import Foundation

func solution(_ cacheSize: Int, _ cities: [String]) -> Int {
    var stack: [String] = []
    var time = 0
    
    for c in cities {
        // 대소문자 구분 없이 처리하기 위해
        let city = c.uppercased()
        var isContained = false
        
        for i in 0..<stack.count {
            let value = stack[i]
            
            if value == city {
                stack.remove(at: i)
                stack.append(value)
                time += 1
                isContained = true
                break
            }
        }
        
        if !isContained {
            stack.append(city)
            time += 5
            
            if stack.count > cacheSize {
                stack.removeFirst()
            }
        }
    }
    
    return time
}
