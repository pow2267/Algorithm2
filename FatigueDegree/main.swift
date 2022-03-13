//
//  [프로그래머스] 주어진 피로도로 돌 수 있는 던젼의 최대 개수 구하기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/87946
//

import Foundation

func solution(_ k: Int, _ dungeons: [[Int]]) -> Int {
    var count = 0
    
    // 순서대로 남은 던젼, 남은 피로도, 남은 던젼 중 다음에 갈 던젼의 index, 방문한 던젼의 개수
    func dfs(_ leftD: [[Int]], _ leftK: Int, _ index: Int, _ visited: Int) {
        var leftDun = leftD
        let dungeon = leftDun.remove(at: index)
        
        if leftK >= dungeon[0] {
            if leftDun.isEmpty {
                count = (count >= visited + 1 ? count : visited + 1)
            } else {
                for i in 0..<leftDun.count {
                    dfs(leftDun, leftK - dungeon[1], i, visited + 1)
                }
            }
        } else {
            count = (count >= visited ? count : visited)
        }
    }
    
    for i in 0..<dungeons.count {
        dfs(dungeons, k, i, 0)
    }
    
    return count
}
