class Solution:
    def eraseOverlapIntervals(self, intervals: list[list[int]]) -> int:
        intervals.sort(key=lambda x:x[1])
        n = len(intervals)
        prev = 0
        count = 1
        for i in range(1,n):
            if intervals[i][0] >= intervals[prev][1]:
                count += 1
                prev = i
        return n-count