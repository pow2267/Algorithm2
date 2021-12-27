//
//  [프로그래머스] 토너먼트 대진표 예상하기
//  
//
//  https://programmers.co.kr/learn/courses/30/lessons/12985
//

import Foundation

func solution(_ n: Int, _ a: Int, _ b: Int) -> Int {
    var round = 1
    // a와 b중 큰 수, 작은 수 구분하기
    var small = (a < b ? (a % 2 == 0 ? a : a + 1) : (b % 2 == 0 ? b : b + 1))
    var big = (a > b ? (a % 2 == 0 ? a : a + 1) : (b % 2 == 0 ? b : b + 1))
    
    while true {
        // small == big 조건이 있는 이유
        // 1, 2처럼 한 경기에 만났을 때, else구문에서 1 -> 1+1 / 2, 2 -> 2 / 2 로 만들어서
        // 둘 다 1이라는 동일한 값이 되는 경우가 생김
        if (small % 2 == 1 && big == small + 1) || (small == big) {
            break
        } else {
            small = (small % 2 == 0 ? small / 2 : (small + 1) / 2)
            big = (big % 2 == 0 ? big / 2 : (big + 1) / 2)
        }
        
        round += 1
    }
    
    return round
}
