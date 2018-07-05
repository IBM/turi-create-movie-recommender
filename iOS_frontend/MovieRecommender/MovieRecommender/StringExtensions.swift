
extension String {
    
    func distance(to: String) -> Int {
        let (t, s) = (self.characters, to.characters)
        
        let empty = Array<Int>(repeating:0, count: s.count)
        var last = [Int](0...s.count)
        
        for (i, tLett) in t.enumerated() {
            var cur = [i + 1] + empty
            for (j, sLett) in s.enumerated() {
                cur[j + 1] = tLett == sLett ? last[j] : Swift.min(last[j], last[j + 1], cur[j])+1
            }
            last = cur
        }
        return last.last!
    }
    
}
