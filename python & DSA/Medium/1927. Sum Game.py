class Solution:
    def sumGame(self, num: str) -> bool:
        n=len(num)
        sumL = sumR = qL = qR = 0 

        for i in range(n):
            if i < n // 2:
                if num[i] == '?':
                    qL += 1
                else:
                    sumL += int(num[i])
            else:
                if num[i] == '?':
                    qR += 1
                else: